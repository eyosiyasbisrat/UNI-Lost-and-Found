import { IUser } from '../entities/User';

export interface IUserRepository {
  findByEmail(email: string): Promise<IUser | null>;
  create(userData: IUser): Promise<IUser>;
  findById(id: string): Promise<IUser | null>;
  update(id: string, user: Partial<IUser>): Promise<IUser | null>;
  delete(id: string): Promise<boolean>;
} 