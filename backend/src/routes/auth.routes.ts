import express from 'express';
import { AuthService } from '../application/services/auth.service';
import { UserRepository } from '../infrastructure/repositories/UserRepository';

const router = express.Router();
const userRepository = new UserRepository();
const authService = new AuthService(userRepository);

// Register route
router.post('/auth/register', async (req, res) => {
  try {
    const { email, password, fullName } = req.body;
    const result = await authService.register({ email, password, fullName });
    res.status(201).json(result);
  } catch (error: any) {
    res.status(400).json({ message: error?.message || 'Registration failed' });
  }
});

// Login route
router.post('/auth/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    const result = await authService.login(email, password);
    res.status(200).json(result);
  } catch (error: any) {
    res.status(401).json({ message: error?.message || 'Login failed' });
  }
});

export default router; 