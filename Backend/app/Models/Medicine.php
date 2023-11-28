<?php

namespace App\Models;

use DateTime;
use Dotenv\Parser\Value;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Model;

class Medicine extends Model
{
    use HasFactory;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = [
        "expiry_date",
        "quantity_available",
        "price",
        "image",
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'expiry_date' => 'date:d/m/Y',
    ];

    /**
     * Interact with the medicine's ExpiryDate.
     */
    protected function ExpiryDate(): Attribute
    {
        return Attribute::make(
            set: fn (string $value) => DateTime::createFromFormat('d/m/Y', $value)->format('Y-m-d'),
        );
    }

    /**
     * Interact with the medicine's Image.
     */
    protected function Image(): Attribute
    {
        return Attribute::make(
            set: fn ($array) => implode(',', $array),
            get: fn ($string) => array_map('intval', explode(',', $string)),
        );
    }

    // OneToMany Relation
    public function  MedicineTranslations()
    {
        return $this->hasMany(MedicineTranslation::class, "medicine_id");
    }
    // ManyToMany Relation
    public function Categories()
    {
        return $this->belongsToMany(Category::class, 'medicine_category', 'medicine_id', 'category_id');
    }
}
