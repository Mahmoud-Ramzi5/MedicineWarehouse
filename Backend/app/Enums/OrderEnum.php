<?php

namespace App\Enums;

enum OrderEnum: string {
    case PREPARING = 'PREPARING';
    case SENT = 'SENT';
    case RECEIVED = 'RECEIVED';

    case يتم_التجهيز = 'يتم التجهيز';
    case تم_الإرسال = 'تم الإرسال';
    case مستلمة = 'مستلمة';
}
