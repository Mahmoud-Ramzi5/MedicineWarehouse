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
     * Returns image_path as Image
     */
    protected function ImagePath(): Attribute
    {
        return Attribute::make(
            get: function ($path) {
                //$localFileName  = storage_path('app/' . $path);
                //$type = explode('.', implode(explode('/', $path)))[1];
                //$fileData = file_get_contents($localFileName);
                //$ImgFileEncode = 'data:image/'.$type.';base64,'.base64_encode($fileData);
                $data = base64_encode(Storage::get($path));
                return $data;
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
}
