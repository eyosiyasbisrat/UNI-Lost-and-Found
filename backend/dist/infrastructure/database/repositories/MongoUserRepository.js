"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.MongoUserRepository = void 0;
const mongoose_1 = __importDefault(require("mongoose"));
const userSchema = new mongoose_1.default.Schema({
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    fullName: { type: String, required: true },
    role: { type: String, enum: ['user', 'admin'], default: 'user' },
    createdAt: { type: Date, default: Date.now },
    updatedAt: { type: Date, default: Date.now },
    resetCode: { type: String },
    resetCodeExpires: { type: Date }
});
const UserModel = mongoose_1.default.model('User', userSchema);
class MongoUserRepository {
    async create(user) {
        const newUser = new UserModel(user);
        const savedUser = await newUser.save();
        return this.mapToEntity(savedUser);
    }
    async findById(id) {
        const user = await UserModel.findById(id);
        return user ? this.mapToEntity(user) : null;
    }
    async findByEmail(email) {
        const user = await UserModel.findOne({ email });
        return user ? this.mapToEntity(user) : null;
    }
    async update(id, userData) {
        const updatedUser = await UserModel.findByIdAndUpdate(id, { ...userData, updatedAt: new Date() }, { new: true });
        return updatedUser ? this.mapToEntity(updatedUser) : null;
    }
    async delete(id) {
        const result = await UserModel.findByIdAndDelete(id);
        return !!result;
    }
    async findAll() {
        const users = await UserModel.find();
        return users.map(this.mapToEntity);
    }
    mapToEntity(user) {
        return {
            id: user._id.toString(),
            email: user.email,
            password: user.password,
            fullName: user.fullName,
            role: user.role,
            createdAt: user.createdAt,
            updatedAt: user.updatedAt
        };
    }
}
exports.MongoUserRepository = MongoUserRepository;
