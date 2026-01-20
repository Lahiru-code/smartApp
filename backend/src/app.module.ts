import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { ConfigModule } from '@nestjs/config';
import * as Joi from 'joi';
import { PrismaModule } from './prisma/prisma.module';
import { UsersModule } from './users/users.module';
import { AuthModule } from './auth/auth.module';
import { SensorsModule } from './sensors/sensors.module';
import { ThrottlerModule } from '@nestjs/throttler';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
      validationSchema: Joi.object({
        NODE_ENV: Joi.string().valid('development', 'test', 'production').default('development'),
        PORT: Joi.number().default(3000),
        DATABASE_URL: Joi.string().required(),
        JWT_SECRET: Joi.string().min(16).required(),
        JWT_EXPIRES_IN: Joi.string().default('15m'),
      }),
    }),
    ThrottlerModule.forRoot([{ ttl: 60000, limit: 10 }]),
    PrismaModule,
    UsersModule,
    AuthModule,
    SensorsModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
