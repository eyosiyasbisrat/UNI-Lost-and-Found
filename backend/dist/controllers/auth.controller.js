"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.AuthController = void 0;
class AuthController {
    constructor(authService) {
        this.authService = authService;
    }
    async register(req, res) {
        try {
            const { email, password, fullName } = req.body;
            if (!email || !password || !fullName) {
                return res.status(400).json({ message: 'All fields are required' });
            }
            const { token, user } = await this.authService.register({ email, password, fullName });
            // Don't send the password back to the client
            const { password: _, ...userWithoutPassword } = user;
            res.status(201).json({
                message: 'User registered successfully',
                token,
                user: userWithoutPassword
            });
        }
        catch (error) {
            if (error instanceof Error) {
                if (error.message === 'User already exists') {
                    return res.status(409).json({ message: error.message });
                }
            }
            console.error('Registration error:', error);
            res.status(500).json({ message: 'Internal server error' });
        }
    }
    async login(req, res) {
        try {
            const { email, password } = req.body;
            if (!email || !password) {
                return res.status(400).json({ message: 'Email and password are required' });
            }
            const { token, user } = await this.authService.login(email, password);
            // Don't send the password back to the client
            const { password: _, ...userWithoutPassword } = user;
            res.json({
                message: 'Login successful',
                token,
                user: userWithoutPassword
            });
        }
        catch (error) {
            if (error instanceof Error) {
                if (error.message === 'User not found' || error.message === 'Invalid password') {
                    return res.status(401).json({ message: 'Invalid email or password' });
                }
            }
            console.error('Login error:', error);
            res.status(500).json({ message: 'Internal server error' });
        }
    }
}
exports.AuthController = AuthController;
