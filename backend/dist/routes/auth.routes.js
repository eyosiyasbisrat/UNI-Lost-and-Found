"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const auth_service_1 = require("../application/services/auth.service");
const UserRepository_1 = require("../infrastructure/repositories/UserRepository");
const router = express_1.default.Router();
const userRepository = new UserRepository_1.UserRepository();
const authService = new auth_service_1.AuthService(userRepository);
// Register route
router.post('/auth/register', async (req, res) => {
    try {
        const { email, password, fullName } = req.body;
        const result = await authService.register({ email, password, fullName });
        res.status(201).json(result);
    }
    catch (error) {
        res.status(400).json({ message: (error === null || error === void 0 ? void 0 : error.message) || 'Registration failed' });
    }
});
// Login route
router.post('/auth/login', async (req, res) => {
    try {
        const { email, password } = req.body;
        const result = await authService.login(email, password);
        res.status(200).json(result);
    }
    catch (error) {
        res.status(401).json({ message: (error === null || error === void 0 ? void 0 : error.message) || 'Login failed' });
    }
});
exports.default = router;
