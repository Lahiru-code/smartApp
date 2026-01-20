import { Controller, Post, Body, Get, UseGuards, Request } from '@nestjs/common';
import { AuthService } from './auth.service';
import { LoginDto } from './dto/login.dto';
import { RegisterDto } from './dto/register.dto';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { AuthGuard } from '@nestjs/passport';

@ApiTags('auth')
@Controller('auth')
export class AuthController {
  constructor(private auth: AuthService) {}

  @Post('login')
  @UseGuards(AuthGuard('local'))
  async login(@Request() req: any) {
    return this.auth.login(req.user);
  }

  @Post('register')
  async register(@Body() dto: RegisterDto) {
    return this.auth.register(dto.email, dto.password);
  }

  @Get('me')
  @ApiBearerAuth()
  @UseGuards(AuthGuard('jwt'))
  me(@Request() req: any) {
    const user = req.user;
    return { id: user.sub, email: user.email };
  }
}
