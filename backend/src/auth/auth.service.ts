import { Injectable, UnauthorizedException } from '@nestjs/common';
import { UsersService } from '../users/users.service';
import * as argon2 from 'argon2';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  constructor(private users: UsersService, private jwt: JwtService) {}

  async validateUser(email: string, password: string) {
    const user = await this.users.findByEmail(email);
    if (!user) return null;
    const valid = await argon2.verify(user.passwordHash, password);
    if (!valid) return null;
    return user;
  }

  async login(user: { id: string; email: string }) {
    const payload = { sub: user.id, email: user.email };
    return { access_token: await this.jwt.signAsync(payload) };
  }

  async register(email: string, password: string) {
    const existing = await this.users.findByEmail(email);
    if (existing) throw new UnauthorizedException('Email already registered');
    const passwordHash = await argon2.hash(password);
    const user = await this.users.createUser({ email, passwordHash });
    return this.login(user);
  }
}
