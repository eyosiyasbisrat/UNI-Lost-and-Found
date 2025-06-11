import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import { IUser } from '../../domain/entities/User';
import { IUserRepository } from '../../domain/repositories/IUserRepository';

export class AuthService {
    private userRepository: IUserRepository;

    constructor(userRepository: IUserRepository) {
        this.userRepository = userRepository;
    }

    async register(userData: { email: string; password: string; fullName: string }): Promise<{ token: string; user: IUser }> {
        const existingUser = await this.userRepository.findByEmail(userData.email);
        if (existingUser) {
            throw new Error('User already exists');
        }

        const hashedPassword = await bcrypt.hash(userData.password, 10);
        const user = await this.userRepository.create({
            email: userData.email,
            password: hashedPassword,
            fullName: userData.fullName,
            role: 'user',
            createdAt: new Date(),
            updatedAt: new Date()
        } as IUser);

        const token = this.generateToken(user);
        return { token, user };
    }

    async login(email: string, password: string): Promise<{ token: string; user: IUser }> {
        const user = await this.userRepository.findByEmail(email);
        if (!user) {
            throw new Error('User not found');
        }

        const isValidPassword = await bcrypt.compare(password, user.password);
        if (!isValidPassword) {
            throw new Error('Invalid password');
        }

        const token = this.generateToken(user);
        return { token, user };
    }

    private generateToken(user: IUser): string {
        if (!user._id) {
            throw new Error('User ID is required for token generation');
        }
        
        return jwt.sign(
            {
                _id: user._id,
                email: user.email,
                role: user.role
            },
            process.env.JWT_SECRET || 'your-secret-key',
            { expiresIn: '24h' }
        );
    }
} 