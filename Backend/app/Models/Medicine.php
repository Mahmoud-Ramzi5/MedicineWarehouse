<?php

namespace App\Models;

use DateTime;
use Dotenv\Parser\Value;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Casts\Attribute;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Storage;

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
        "quantity_total",
        "quantity_allocated",
        "quantity_available",
        "price",
        "image_path",
    ];

    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'created_at',
        'updated_at',
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
     * Interact with the medicine's Image.
     * Returns image_path as Image
     */
    protected function ImagePath(): Attribute
    {
        return Attribute::make(
            get: function ($path) {
                $path = explode('/', $path);
                return $path[1];
            }
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

    // ManyToMany Relation
    public function Orders()
    {
        return $this->belongsToMany(Order::class, 'order_medicine', 'medicine_id', 'order_id');
    }
}
