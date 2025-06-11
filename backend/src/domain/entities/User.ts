export interface IUser {
  _id?: string;
  id: string;
  email: string;
  password: string;
  fullName: string;
  role: 'user' | 'admin';
  createdAt: Date;
  updatedAt: Date;
  resetCode?: string;
  resetCodeExpires?: Date;
}

export class User implements IUser {
  _id?: string;
  id: string;
  email: string;
  password: string;
  fullName: string;
  role: 'user' | 'admin';
  createdAt: Date;
  updatedAt: Date;
  resetCode?: string;
  resetCodeExpires?: Date;

  constructor(data: Partial<IUser>) {
    this._id = data._id;
    this.id = data.id || '';
    this.email = data.email || '';
    this.password = data.password || '';
    this.fullName = data.fullName || '';
    this.role = data.role || 'user';
    this.createdAt = data.createdAt || new Date();
    this.updatedAt = data.updatedAt || new Date();
    this.resetCode = data.resetCode;
    this.resetCodeExpires = data.resetCodeExpires;
  }

  toJSON(): IUser {
    return {
      _id: this._id,
      id: this.id,
      email: this.email,
      password: this.password,
      fullName: this.fullName,
      role: this.role,
      createdAt: this.createdAt,
      updatedAt: this.updatedAt,
      resetCode: this.resetCode,
      resetCodeExpires: this.resetCodeExpires
    };
  }
} 