"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const AuthController_1 = require("../controllers/AuthController");
const auth_1 = require("../middleware/auth");
const MongoUserRepository_1 = require("@infrastructure/database/repositories/MongoUserRepository");
const router = (0, express_1.Router)();
const authController = new AuthController_1.AuthController();
const userRepository = new MongoUserRepository_1.MongoUserRepository();
router.post('/register', authController.register.bind(authController));
router.post('/login', authController.login.bind(authController));
// Example admin route: delete any user
router.delete('/users/:id', auth_1.authenticateToken, auth_1.requireAdmin, async (req, res) => {
    const userId = req.params.id;
    try {
        const deleted = await userRepository.delete(userId);
        if (deleted) {
            res.json({ message: 'User deleted successfully' });
        }
        else {
            res.status(404).json({ message: 'User not found' });
        }
    }
    catch (error) {
        res.status(500).json({ message: 'Failed to delete user' });
    }
});
// Admin: list all users
router.get('/users', auth_1.authenticateToken, auth_1.requireAdmin, async (req, res) => {
    try {
        const users = await userRepository.findAll();
        res.json(users);
    }
    catch (error) {
        res.status(500).json({ message: 'Failed to fetch users' });
    }
});
// Admin: update any user's role
router.put('/users/:id/role', auth_1.authenticateToken, auth_1.requireAdmin, async (req, res) => {
    const userId = req.params.id;
    const { role } = req.body; // 'user' or 'admin'
    try {
        const updatedUser = await userRepository.update(userId, { role });
        if (updatedUser) {
            res.json({ message: 'User role updated', user: updatedUser });
        }
        else {
            res.status(404).json({ message: 'User not found' });
        }
    }
    catch (error) {
        res.status(500).json({ message: 'Failed to update user role' });
    }
});
// Admin: view any user's details
router.get('/users/:id', auth_1.authenticateToken, auth_1.requireAdmin, async (req, res) => {
    const userId = req.params.id;
    try {
        const user = await userRepository.findById(userId);
        if (user) {
            res.json(user);
        }
        else {
            res.status(404).json({ message: 'User not found' });
        }
    }
    catch (error) {
        res.status(500).json({ message: 'Failed to fetch user' });
    }
});
// Password reset endpoints
router.post('/request-password-reset', authController.requestPasswordReset.bind(authController));
router.post('/reset-password', authController.resetPassword.bind(authController));
router.put('/change-password', auth_1.authenticateToken, authController.changePassword.bind(authController));
router.delete('/delete-account', auth_1.authenticateToken, authController.deleteAccount.bind(authController));
router.put('/update-profile', auth_1.authenticateToken, authController.updateProfile.bind(authController));
router.get('/debug-users', authController.debugListUsers.bind(authController));
exports.default = router;
