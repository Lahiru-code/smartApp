import { Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma/prisma.service';
import { PrismaClient } from '@prisma/client';
import { CreateDeviceDto, CreateReadingDto } from './dto/sensor.dto';

@Injectable()
export class SensorsService {
  constructor(private prisma: PrismaService) {}
  private get client(): PrismaClient {
    return this.prisma as PrismaClient;
  }

  createDevice(userId: string, dto: CreateDeviceDto) {
    return (this.client as any).device.create({
      data: { name: dto.name, type: dto.type, userId },
    });
  }


  getUserDevices(userId: string) {
    return (this.client as any).device.findMany({
      where: { userId },
      include: {
        readings: {
          orderBy: { timestamp: 'desc' },
          take: 1,
        },
      },
    });
  }

  async addReading(deviceId: string, dto: CreateReadingDto) {
    return (this.client as any).sensorReading.create({
      data: {
        deviceId,
        value: dto.value,
        unit: dto.unit,
      },
    });
  }

  async getReadings(deviceId: string, limit = 100, from?: Date, to?: Date) {
    return (this.client as any).sensorReading.findMany({
      where: {
        deviceId,
        timestamp: {
          gte: from,
          lte: to,
        },
      },
      orderBy: { timestamp: 'desc' },
      take: limit,
    });
  }

  async getLatestReading(deviceId: string) {
    return (this.client as any).sensorReading.findFirst({
      where: { deviceId },
      orderBy: { timestamp: 'desc' },
    });
  }
}
