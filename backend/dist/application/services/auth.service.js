"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthService = void 0;
const bcrypt_1 = __importDefault(require("bcrypt"));
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
class AuthService {
    constructor(userRepository) {
        this.userRepository = userRepository;
    }
    async register(userData) {
        const existingUser = await this.userRepository.findByEmail(userData.email);
        if (existingUser) {
            throw new Error('User already exists');
        }
        const hashedPassword = await bcrypt_1.default.hash(userData.password, 10);
        const user = await this.userRepository.create({
            email: userData.email,
            password: hashedPassword,
            fullName: userData.fullName,
            role: 'user',
            createdAt: new Date(),
            updatedAt: new Date()
        });
        const token = this.generateToken(user);
        return { token, user };
    }
    async login(email, password) {
        const user = await this.userRepository.findByEmail(email);
        if (!user) {
            throw new Error('User not found');
        }
        const isValidPassword = await bcrypt_1.default.compare(password, user.password);
        if (!isValidPassword) {
            throw new Error('Invalid password');
        }
        const token = this.generateToken(user);
        return { token, user };
    }
    generateToken(user) {
        if (!user._id) {
            throw new Error('User ID is required for token generation');
        }
        return jsonwebtoken_1.default.sign({
            _id: user._id,
            email: user.email,
            role: user.role
        }, process.env.JWT_SECRET || 'your-secret-key', { expiresIn: '24h' });
    }
}
exports.AuthService = AuthService;
