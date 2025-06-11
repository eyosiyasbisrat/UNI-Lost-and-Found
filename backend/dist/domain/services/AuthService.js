"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthService = void 0;
const bcryptjs_1 = __importDefault(require("bcryptjs"));
const jsonwebtoken_1 = __importDefault(require("jsonwebtoken"));
class AuthService {
    constructor(userRepository, jwtSecret = process.env.JWT_SECRET || 'your_jwt_secret_key_here', jwtExpiresIn = process.env.JWT_EXPIRES_IN || '7d') {
        this.userRepository = userRepository;
        this.jwtSecret = jwtSecret;
        this.jwtExpiresIn = jwtExpiresIn;
    }
    async register(userData) {
        const existingUser = await this.userRepository.findByEmail(userData.email);
        if (existingUser) {
            throw new Error('User already exists');
        }
        const hashedPassword = await bcryptjs_1.default.hash(userData.password, 10);
        const isAdmin = userData.email === 'admin@example.com'; // Set your admin email here
        const user = await this.userRepository.create({
            ...userData,
            password: hashedPassword,
            role: isAdmin ? 'admin' : 'user'
        });
        return user;
    }
    async login(email, password) {
        const user = await this.userRepository.findByEmail(email);
        if (!user) {
            throw new Error('User not found');
        }
        const isValidPassword = await bcryptjs_1.default.compare(password, user.password);
        if (!isValidPassword) {
            throw new Error('Invalid password');
        }
        const signOptions = { expiresIn: this.jwtExpiresIn };
        const token = jsonwebtoken_1.default.sign({ _id: user.id, email: user.email, role: user.role }, this.jwtSecret, signOptions);
        return { user, token };
    }
    async verifyToken(token) {
        try {
            const decoded = jsonwebtoken_1.default.verify(token, this.jwtSecret);
            const user = await this.userRepository.findById(decoded.userId);
            if (!user) {
                throw new Error('User not found');
            }
            return user;
        }
        catch (error) {
            throw new Error('Invalid token');
        }
    }
}
exports.AuthService = AuthService;
