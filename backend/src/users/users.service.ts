import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  findByEmail(email: string) {
    return this.prisma.user.findUnique({ where: { email } });
  }

  createUser(data: { email: string; passwordHash: string }) {
    return this.prisma.user.create({ data: { email: data.email, passwordHash: data.passwordHash } });
  }

  findById(id: string) {
    return this.prisma.user.findUnique({ where: { id } });
  }
}
