"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.UserRepository = void 0;
const mongoose_1 = __importDefault(require("mongoose"));
const userSchema = new mongoose_1.default.Schema({
    email: { type: String, required: true, unique: true },
    password: { type: String, required: true },
    fullName: { type: String, required: true },
    role: { type: String, enum: ['user', 'admin'], default: 'user' },
    createdAt: { type: Date, default: Date.now },
    updatedAt: { type: Date, default: Date.now },
    resetCode: String,
    resetCodeExpires: Date
});
const UserModel = mongoose_1.default.model('User', userSchema);
class UserRepository {
    async findByEmail(email) {
        const user = await UserModel.findOne({ email });
        return user ? this.mapToUser(user) : null;
    }
    async findById(id) {
        const user = await UserModel.findById(id);
        return user ? this.mapToUser(user) : null;
    }
    async create(userData) {
        const user = new UserModel(userData);
        await user.save();
        return this.mapToUser(user);
    }
    async update(id, userData) {
        const user = await UserModel.findByIdAndUpdate(id, userData, { new: true });
        return user ? this.mapToUser(user) : null;
    }
    async delete(id) {
        const result = await UserModel.findByIdAndDelete(id);
        return result !== null;
    }
    mapToUser(mongooseUser) {
        return {
            _id: mongooseUser._id.toString(),
            id: mongooseUser._id.toString(),
            email: mongooseUser.email,
            password: mongooseUser.password,
            fullName: mongooseUser.fullName,
            role: mongooseUser.role,
            createdAt: mongooseUser.createdAt,
            updatedAt: mongooseUser.updatedAt,
            resetCode: mongooseUser.resetCode,
            resetCodeExpires: mongooseUser.resetCodeExpires
        };
    }
}
exports.UserRepository = UserRepository;
