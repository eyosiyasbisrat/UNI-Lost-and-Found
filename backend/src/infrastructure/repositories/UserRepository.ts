import { IUser } from '../../domain/entities/User';
import { IUserRepository } from '../../domain/repositories/IUserRepository';
import mongoose from 'mongoose';

const userSchema = new mongoose.Schema({
  email: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  fullName: { type: String, required: true },
  role: { type: String, enum: ['user', 'admin'], default: 'user' },
  createdAt: { type: Date, default: Date.now },
  updatedAt: { type: Date, default: Date.now },
  resetCode: String,
  resetCodeExpires: Date
});

const UserModel = mongoose.model('User', userSchema);

export class UserRepository implements IUserRepository {
  async findByEmail(email: string): Promise<IUser | null> {
    const user = await UserModel.findOne({ email });
    return user ? this.mapToUser(user) : null;
  }

  async findById(id: string): Promise<IUser | null> {
    const user = await UserModel.findById(id);
    return user ? this.mapToUser(user) : null;
  }

  async create(userData: IUser): Promise<IUser> {
    const user = new UserModel(userData);
    await user.save();
    return this.mapToUser(user);
  }

  async update(id: string, userData: Partial<IUser>): Promise<IUser | null> {
    const user = await UserModel.findByIdAndUpdate(id, userData, { new: true });
    return user ? this.mapToUser(user) : null;
  }

  async delete(id: string): Promise<boolean> {
    const result = await UserModel.findByIdAndDelete(id);
    return result !== null;
  }

  private mapToUser(mongooseUser: any): IUser {
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