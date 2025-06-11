"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.User = void 0;
class User {
    constructor(data) {
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
    toJSON() {
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
exports.User = User;
