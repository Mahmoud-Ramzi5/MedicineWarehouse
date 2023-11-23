<?php

namespace App\Models;

use DateTime;
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
        "Expiry_date",
        "Quantity_available",
        "Price",
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'Expiry_date' => 'date:Y-m-d',
    ];

    /**
     * Interact with the medicine's Expiry_date.
     */
    protected function ExpiryDate(): Attribute
    {
        return Attribute::make(
            set: fn (string $value) => DateTime::createFromFormat('d/m/Y', $value)->format('Y-m-d'),
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
