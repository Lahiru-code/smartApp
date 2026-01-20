import { ApiProperty } from '@nestjs/swagger';
import { IsString, IsNumber, IsOptional } from 'class-validator';

export class CreateDeviceDto {
  @ApiProperty()
  @IsString()
  name: string;

  @ApiProperty({ example: 'temperature' })
  @IsString()
  type: string;
}

export class CreateReadingDto {
  @ApiProperty()
  @IsNumber()
  value: number;

  @ApiProperty({ example: '°C' })
  @IsString()
  unit: string;
}

export class QueryReadingsDto {
  @ApiProperty({ required: false })
  @IsOptional()
  @IsNumber()
  limit?: number;

  @ApiProperty({ required: false })
  @IsOptional()
  from?: string;

  @ApiProperty({ required: false })
  @IsOptional()
  to?: string;
}
