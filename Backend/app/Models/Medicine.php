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
        "quantity_available",
        "price",
        "image_path",
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
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        "image_path",
    ];

    /**
     * Interact with the medicine's ExpiryDate.
     */
    protected function ExpiryDate(): Attribute
    {
        return Attribute::make(
            set: fn (string $date) => DateTime::createFromFormat('d/m/Y', $date)->format('Y-m-d'),
        );
    }

    /**
     * Interact with the medicine's Image.
     */
    /*protected function Image(): Attribute
    {
        return Attribute::make(
            get: function ($path) {
                if ($path == null) {
                    return "";
                }
                else {
                    $localFileName  = storage_path('app/' . $path);
                    $fileData = file_get_contents($localFileName);
                    $ImgFileEncode = base64_encode($fileData);
                    return $ImgFileEncode;
                    return base64_encode($ImgFileEncode);
                }
            }
        );
    }*/

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
