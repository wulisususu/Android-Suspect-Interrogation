.class public Lcom/capacitorjs/plugins/camera/ImageUtils;
.super Ljava/lang/Object;
.source "ImageUtils.java"


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 15
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static correctOrientation(Landroid/content/Context;Landroid/graphics/Bitmap;Landroid/net/Uri;Lcom/capacitorjs/plugins/camera/ExifWrapper;)Landroid/graphics/Bitmap;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 75
    invoke-static {p0, p2}, Lcom/capacitorjs/plugins/camera/ImageUtils;->getOrientation(Landroid/content/Context;Landroid/net/Uri;)I

    move-result p0

    if-eqz p0, :cond_0

    .line 77
    new-instance p2, Landroid/graphics/Matrix;

    invoke-direct {p2}, Landroid/graphics/Matrix;-><init>()V

    int-to-float p0, p0

    .line 78
    invoke-virtual {p2, p0}, Landroid/graphics/Matrix;->postRotate(F)Z

    .line 79
    invoke-virtual {p3}, Lcom/capacitorjs/plugins/camera/ExifWrapper;->resetOrientation()V

    .line 80
    invoke-static {p1, p2}, Lcom/capacitorjs/plugins/camera/ImageUtils;->transform(Landroid/graphics/Bitmap;Landroid/graphics/Matrix;)Landroid/graphics/Bitmap;

    move-result-object p0

    return-object p0

    :cond_0
    return-object p1
.end method

.method public static getExifData(Landroid/content/Context;Landroid/graphics/Bitmap;Landroid/net/Uri;)Lcom/capacitorjs/plugins/camera/ExifWrapper;
    .locals 2

    const/4 p1, 0x0

    .line 109
    :try_start_0
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p0

    invoke-virtual {p0, p2}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object p0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_2
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 110
    :try_start_1
    new-instance p2, Landroidx/exifinterface/media/ExifInterface;

    invoke-direct {p2, p0}, Landroidx/exifinterface/media/ExifInterface;-><init>(Ljava/io/InputStream;)V

    .line 112
    new-instance v0, Lcom/capacitorjs/plugins/camera/ExifWrapper;

    invoke-direct {v0, p2}, Lcom/capacitorjs/plugins/camera/ExifWrapper;-><init>(Landroidx/exifinterface/media/ExifInterface;)V
    :try_end_1
    .catch Ljava/io/IOException; {:try_start_1 .. :try_end_1} :catch_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    if-eqz p0, :cond_0

    .line 118
    :try_start_2
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_2
    .catch Ljava/io/IOException; {:try_start_2 .. :try_end_2} :catch_0

    :catch_0
    :cond_0
    return-object v0

    :catch_1
    move-exception p2

    goto :goto_0

    :catchall_0
    move-exception p0

    move-object v1, p1

    move-object p1, p0

    move-object p0, v1

    goto :goto_1

    :catch_2
    move-exception p2

    move-object p0, p1

    :goto_0
    :try_start_3
    const-string v0, "Error loading exif data from image"

    .line 114
    invoke-static {v0, p2}, Lcom/getcapacitor/Logger;->error(Ljava/lang/String;Ljava/lang/Throwable;)V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    if-eqz p0, :cond_1

    .line 118
    :try_start_4
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_4
    .catch Ljava/io/IOException; {:try_start_4 .. :try_end_4} :catch_3

    .line 122
    :catch_3
    :cond_1
    new-instance p0, Lcom/capacitorjs/plugins/camera/ExifWrapper;

    invoke-direct {p0, p1}, Lcom/capacitorjs/plugins/camera/ExifWrapper;-><init>(Landroidx/exifinterface/media/ExifInterface;)V

    return-object p0

    :catchall_1
    move-exception p1

    :goto_1
    if-eqz p0, :cond_2

    .line 118
    :try_start_5
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_5
    .catch Ljava/io/IOException; {:try_start_5 .. :try_end_5} :catch_4

    .line 121
    :catch_4
    :cond_2
    throw p1
.end method

.method private static getOrientation(Landroid/content/Context;Landroid/net/Uri;)I
    .locals 2
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Ljava/io/IOException;
        }
    .end annotation

    .line 89
    invoke-virtual {p0}, Landroid/content/Context;->getContentResolver()Landroid/content/ContentResolver;

    move-result-object p0

    invoke-virtual {p0, p1}, Landroid/content/ContentResolver;->openInputStream(Landroid/net/Uri;)Ljava/io/InputStream;

    move-result-object p0

    .line 90
    :try_start_0
    new-instance p1, Landroidx/exifinterface/media/ExifInterface;

    invoke-direct {p1, p0}, Landroidx/exifinterface/media/ExifInterface;-><init>(Ljava/io/InputStream;)V

    const-string v0, "Orientation"

    const/4 v1, 0x1

    .line 92
    invoke-virtual {p1, v0, v1}, Landroidx/exifinterface/media/ExifInterface;->getAttributeInt(Ljava/lang/String;I)I

    move-result p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    const/4 v0, 0x6

    if-ne p1, v0, :cond_0

    const/16 p1, 0x5a

    goto :goto_0

    :cond_0
    const/4 v0, 0x3

    if-ne p1, v0, :cond_1

    const/16 p1, 0xb4

    goto :goto_0

    :cond_1
    const/16 v0, 0x8

    if-ne p1, v0, :cond_2

    const/16 p1, 0x10e

    goto :goto_0

    :cond_2
    const/4 p1, 0x0

    :goto_0
    if-eqz p0, :cond_3

    .line 101
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V

    :cond_3
    return p1

    :catchall_0
    move-exception p1

    if-eqz p0, :cond_4

    .line 89
    :try_start_1
    invoke-virtual {p0}, Ljava/io/InputStream;->close()V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    goto :goto_1

    :catchall_1
    move-exception p0

    invoke-virtual {p1, p0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :cond_4
    :goto_1
    throw p1
.end method

.method public static resize(Landroid/graphics/Bitmap;II)Landroid/graphics/Bitmap;
    .locals 0

    .line 26
    invoke-static {p0, p1, p2}, Lcom/capacitorjs/plugins/camera/ImageUtils;->resizePreservingAspectRatio(Landroid/graphics/Bitmap;II)Landroid/graphics/Bitmap;

    move-result-object p0

    return-object p0
.end method

.method private static resizePreservingAspectRatio(Landroid/graphics/Bitmap;II)Landroid/graphics/Bitmap;
    .locals 5

    .line 38
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v0

    .line 39
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v1

    if-nez p2, :cond_0

    move p2, v1

    :cond_0
    if-nez p1, :cond_1

    move p1, v0

    .line 46
    :cond_1
    invoke-static {v0, p1}, Ljava/lang/Math;->min(II)I

    move-result p1

    int-to-float p1, p1

    int-to-float v2, v1

    mul-float/2addr v2, p1

    int-to-float v3, v0

    div-float/2addr v2, v3

    int-to-float v3, p2

    cmpl-float v4, v2, v3

    if-lez v4, :cond_2

    mul-int/2addr v0, p2

    .line 50
    div-int/2addr v0, v1

    int-to-float p1, v0

    move v2, v3

    .line 53
    :cond_2
    invoke-static {p1}, Ljava/lang/Math;->round(F)I

    move-result p1

    invoke-static {v2}, Ljava/lang/Math;->round(F)I

    move-result p2

    const/4 v0, 0x0

    invoke-static {p0, p1, p2, v0}, Landroid/graphics/Bitmap;->createScaledBitmap(Landroid/graphics/Bitmap;IIZ)Landroid/graphics/Bitmap;

    move-result-object p0

    return-object p0
.end method

.method private static transform(Landroid/graphics/Bitmap;Landroid/graphics/Matrix;)Landroid/graphics/Bitmap;
    .locals 7

    const/4 v1, 0x0

    const/4 v2, 0x0

    .line 63
    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getWidth()I

    move-result v3

    invoke-virtual {p0}, Landroid/graphics/Bitmap;->getHeight()I

    move-result v4

    const/4 v6, 0x1

    move-object v0, p0

    move-object v5, p1

    invoke-static/range {v0 .. v6}, Landroid/graphics/Bitmap;->createBitmap(Landroid/graphics/Bitmap;IIIILandroid/graphics/Matrix;Z)Landroid/graphics/Bitmap;

    move-result-object p0

    return-object p0
.end method
