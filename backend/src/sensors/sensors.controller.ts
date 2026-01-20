import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  UseGuards,
  Request,
  Query,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { ApiBearerAuth, ApiTags } from '@nestjs/swagger';
import { SensorsService } from './sensors.service';
import { CreateDeviceDto, CreateReadingDto, QueryReadingsDto } from './dto/sensor.dto';

@ApiTags('sensors')
@ApiBearerAuth()
@UseGuards(AuthGuard('jwt'))
@Controller('sensors')
export class SensorsController {
  constructor(private sensors: SensorsService) {}

  @Post('devices')
  createDevice(@Request() req: any, @Body() dto: CreateDeviceDto) {
    return this.sensors.createDevice(req.user.sub, dto);
  }

  @Get('devices')
  getDevices(@Request() req: any) {
    return this.sensors.getUserDevices(req.user.sub);
  }

  @Post('devices/:deviceId/readings')
  async addReading(@Param('deviceId') deviceId: string, @Body() dto: CreateReadingDto) {
    return this.sensors.addReading(deviceId, dto);
  }

  @Get('devices/:deviceId/readings')
  async getReadings(
    @Param('deviceId') deviceId: string,
    @Query() query: QueryReadingsDto,
  ) {
    const from = query.from ? new Date(query.from) : undefined;
    const to = query.to ? new Date(query.to) : undefined;
    return this.sensors.getReadings(deviceId, query.limit || 100, from, to);
  }

  @Get('devices/:deviceId/latest')
  async getLatest(@Param('deviceId') deviceId: string) {
    return this.sensors.getLatestReading(deviceId);
  }
}
