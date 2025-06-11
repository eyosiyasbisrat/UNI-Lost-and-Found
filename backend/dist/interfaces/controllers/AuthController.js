"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthController = void 0;
const AuthService_1 = require("@domain/services/AuthService");
const MongoUserRepository_1 = require("@infrastructure/database/repositories/MongoUserRepository");
const authService = new AuthService_1.AuthService(new MongoUserRepository_1.MongoUserRepository());
class AuthController {
    async register(req, res) {
        try {
            console.log("here");
            const { email, password, fullName } = req.body;
            const user = await authService.register({ email, password, fullName });
            res.status(201).json({ message: "User registered successfully", user });
        }
        catch (error) {
            res
                .status(400)
                .json({ message: (error === null || error === void 0 ? void 0 : error.message) || "Registration failed" });
        }
    }
    async login(req, res) {
        try {
            const { email, password } = req.body;
            const result = await authService.login(email, password);
            res.json(result);
        }
        catch (error) {
            res.status(401).json({ message: (error === null || error === void 0 ? void 0 : error.message) || "Login failed" });
        }
    }
    async requestPasswordReset(req, res) {
        try {
            const { email } = req.body;
            // Find user
            const userRepo = new MongoUserRepository_1.MongoUserRepository();
            const user = await userRepo.findByEmail(email);
            if (!user) {
                return res.status(404).json({ message: "User not found" });
            }
            // Generate 4-digit code
            const code = Math.floor(1000 + Math.random() * 9000).toString();
            const expires = new Date(Date.now() + 10 * 60 * 1000); // 10 minutes
            // Update user with code and expiration
            await userRepo.update(user.id, {
                resetCode: code,
                resetCodeExpires: expires,
            });
            // Return code in response (for local dev)
            res.json({
                resetCode: code,
                message: "Reset code generated. Use this code to reset your password.",
            });
        }
        catch (error) {
            res
                .status(500)
                .json({ message: (error === null || error === void 0 ? void 0 : error.message) || "Failed to generate reset code" });
        }
    }
    async resetPassword(req, res) {
        try {
            const { email, code, newPassword } = req.body;
            const userRepo = new MongoUserRepository_1.MongoUserRepository();
            const user = await userRepo.findByEmail(email);
            if (!user) {
                return res.status(404).json({ message: "User not found" });
            }
            // Check code and expiration
            if (user.resetCode !== code ||
                !user.resetCodeExpires ||
                new Date(user.resetCodeExpires) < new Date()) {
                return res.status(400).json({ message: "Invalid or expired code" });
            }
            // Update password and clear code
            const bcrypt = require("bcryptjs");
            const hashed = await bcrypt.hash(newPassword, 10);
            await userRepo.update(user.id, {
                password: hashed,
                resetCode: undefined,
                resetCodeExpires: undefined,
            });
            res.json({ message: "Password reset successful" });
        }
        catch (error) {
            res
                .status(500)
                .json({ message: (error === null || error === void 0 ? void 0 : error.message) || "Failed to reset password" });
        }
    }
    async changePassword(req, res) {
        var _a, _b;
        try {
            const userId = (_a = req.user) === null || _a === void 0 ? void 0 : _a._id;
            console.log("User ID from request (ObjectId):", userId);
            console.log("User ID as string:", userId === null || userId === void 0 ? void 0 : userId.toString());
            if (!userId) {
                return res.status(401).json({ message: "User not authenticated" });
            }
            const { oldPassword, newPassword } = req.body;
            const userRepo = new MongoUserRepository_1.MongoUserRepository();
            // Always use string for findById
            const user = await userRepo.findById(userId.toString());
            console.log("Found user object from repo:", user);
            if (user) {
                console.log("User id from repo:", user.id);
                console.log("User email from repo:", user.email);
            }
            else {
                console.log("No user found with ID:", userId.toString());
                // Let's check if the user exists by email
                const userByEmail = await userRepo.findByEmail(((_b = req.user) === null || _b === void 0 ? void 0 : _b.email) || "");
                console.log("User found by email:", userByEmail);
            }
            if (!user) {
                return res.status(404).json({ message: "User not found" });
            }
            const bcrypt = require("bcryptjs");
            const isMatch = await bcrypt.compare(oldPassword, user.password);
            if (!isMatch) {
                return res.status(400).json({ message: "Old password is incorrect" });
            }
            const hashed = await bcrypt.hash(newPassword, 10);
            // Use user.id for update
            const updatedUser = await userRepo.update(user.id, { password: hashed });
            console.log("Updated user:", updatedUser);
            res.json({ message: "Password changed successfully" });
        }
        catch (error) {
            console.error("Change password error:", error);
            res
                .status(500)
                .json({ message: (error === null || error === void 0 ? void 0 : error.message) || "Failed to change password" });
        }
    }
    async deleteAccount(req, res) {
        var _a;
        try {
            const userId = (_a = req.user) === null || _a === void 0 ? void 0 : _a._id;
            if (!userId) {
                return res.status(401).json({ message: "User not authenticated" });
            }
            const userRepo = new MongoUserRepository_1.MongoUserRepository();
            const deleted = await userRepo.delete(userId.toString());
            if (deleted) {
                res.json({ message: "Account deleted successfully" });
            }
            else {
                res.status(404).json({ message: "User not found" });
            }
        }
        catch (error) {
            res
                .status(500)
                .json({ message: (error === null || error === void 0 ? void 0 : error.message) || "Failed to delete account" });
        }
    }
    async updateProfile(req, res) {
        var _a;
        try {
            const userId = (_a = req.user) === null || _a === void 0 ? void 0 : _a._id;
            if (!userId) {
                return res.status(401).json({ message: "User not authenticated" });
            }
            const { fullName, email } = req.body;
            const userRepo = new MongoUserRepository_1.MongoUserRepository();
            const updatedUser = await userRepo.update(userId.toString(), {
                fullName,
                email,
            });
            if (updatedUser) {
                res.json({
                    message: "Profile updated successfully",
                    user: updatedUser,
                });
            }
            else {
                res.status(404).json({ message: "User not found" });
            }
        }
        catch (error) {
            res
                .status(500)
                .json({ message: (error === null || error === void 0 ? void 0 : error.message) || "Failed to update profile" });
        }
    }
    async debugListUsers(req, res) {
        try {
            const userRepo = new MongoUserRepository_1.MongoUserRepository();
            const users = await userRepo.findAll();
            res.json(users.map((u) => ({ id: u.id, email: u.email, fullName: u.fullName })));
        }
        catch (error) {
            res
                .status(500)
                .json({ message: (error === null || error === void 0 ? void 0 : error.message) || "Failed to list users" });
        }
    }
}
exports.AuthController = AuthController;
