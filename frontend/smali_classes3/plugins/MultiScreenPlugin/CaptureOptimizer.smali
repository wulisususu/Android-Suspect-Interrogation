.class public Lplugins/MultiScreenPlugin/CaptureOptimizer;
.super Ljava/lang/Object;
.source "CaptureOptimizer.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;
    }
.end annotation


# static fields
.field private static final JPEG_QUALITY:I = 0x46

.field private static final SCALE_FACTOR:F = 1.0f

.field private static final TAG:Ljava/lang/String; = "CaptureOptimizer"


# instance fields
.field private paint:Landroid/graphics/Paint;

.field private scaleMatrix:Landroid/graphics/Matrix;


# direct methods
.method public static synthetic $r8$lambda$Gbqt7wcms_z258myf0A9ljBh1do(Lplugins/MultiScreenPlugin/CaptureOptimizer;Landroid/graphics/Bitmap;Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;I)V
    .locals 0

    invoke-direct {p0, p1, p2, p3}, Lplugins/MultiScreenPlugin/CaptureOptimizer;->lambda$captureOptimized$0(Landroid/graphics/Bitmap;Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;I)V

    return-void
.end method

.method public constructor <init>()V
    .locals 2

    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 35
    new-instance v0, Landroid/graphics/Paint;

    const/4 v1, 0x3

    invoke-direct {v0, v1}, Landroid/graphics/Paint;-><init>(I)V

    iput-object v0, p0, Lplugins/MultiScreenPlugin/CaptureOptimizer;->paint:Landroid/graphics/Paint;

    .line 36
    new-instance v0, Landroid/graphics/Matrix;

    invoke-direct {v0}, Landroid/graphics/Matrix;-><init>()V

    iput-object v0, p0, Lplugins/MultiScreenPlugin/CaptureOptimizer;->scaleMatrix:Landroid/graphics/Matrix;

    return-void
.end method

.method private synthetic lambda$captureOptimized$0(Landroid/graphics/Bitmap;Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;I)V
    .locals 2

    if-nez p3, :cond_1

    .line 87
    new-instance p3, Ljava/io/ByteArrayOutputStream;

    invoke-direct {p3}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 88
    sget-object v0, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v1, 0x46

    invoke-virtual {p1, v0, v1, p3}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    move-result v0

    .line 89
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->recycle()V

    if-eqz v0, :cond_0

    .line 91
    invoke-virtual {p3}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p1

    invoke-interface {p2, p1}, Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;->onSuccess([B)V

    goto :goto_0

    :cond_0
    const-string p1, "JPEG\u538b\u7f29\u5931\u8d25"

    .line 93
    invoke-interface {p2, p1}, Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;->onError(Ljava/lang/String;)V

    goto :goto_0

    .line 96
    :cond_1
    new-instance p1, Ljava/lang/StringBuilder;

    const-string v0, "PixelCopy\u5931\u8d25: "

    invoke-direct {p1, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1, p3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {p2, p1}, Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;->onError(Ljava/lang/String;)V

    :goto_0
    return-void
.end method


# virtual methods
.method public captureOptimized(Landroid/view/Window;Landroid/view/View;Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;)V
    .locals 7

    if-eqz p2, :cond_4

    .line 57
    invoke-virtual {p2}, Landroid/view/View;->getWidth()I

    move-result v0

    if-lez v0, :cond_4

    invoke-virtual {p2}, Landroid/view/View;->getHeight()I

    move-result v0

    if-gtz v0, :cond_0

    goto/16 :goto_1

    :cond_0
    if-nez p1, :cond_1

    const-string p1, "Window\u4e0d\u80fd\u4e3a\u7a7a"

    .line 62
    invoke-interface {p3, p1}, Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;->onError(Ljava/lang/String;)V

    return-void

    .line 66
    :cond_1
    instance-of v0, p2, Landroid/webkit/WebView;

    if-eqz v0, :cond_2

    .line 68
    invoke-virtual {p2}, Landroid/view/View;->getWidth()I

    move-result v0

    invoke-virtual {p2}, Landroid/view/View;->getHeight()I

    move-result v1

    sget-object v2, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {v0, v1, v2}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object v0

    const/4 v1, 0x2

    new-array v1, v1, [I

    .line 70
    invoke-virtual {p2, v1}, Landroid/view/View;->getLocationInWindow([I)V

    .line 71
    new-instance v2, Landroid/graphics/Rect;

    const/4 v3, 0x0

    aget v3, v1, v3

    const/4 v4, 0x1

    aget v5, v1, v4

    invoke-virtual {p2}, Landroid/view/View;->getWidth()I

    move-result v6

    add-int/2addr v6, v3

    aget v1, v1, v4

    invoke-virtual {p2}, Landroid/view/View;->getHeight()I

    move-result p2

    add-int/2addr v1, p2

    invoke-direct {v2, v3, v5, v6, v1}, Landroid/graphics/Rect;-><init>(IIII)V

    .line 73
    :try_start_0
    new-instance p2, Lplugins/MultiScreenPlugin/CaptureOptimizer$$ExternalSyntheticLambda0;

    invoke-direct {p2, p0, v0, p3}, Lplugins/MultiScreenPlugin/CaptureOptimizer$$ExternalSyntheticLambda0;-><init>(Lplugins/MultiScreenPlugin/CaptureOptimizer;Landroid/graphics/Bitmap;Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;)V

    new-instance v1, Landroid/os/Handler;

    .line 98
    invoke-static {}, Landroid/os/Looper;->getMainLooper()Landroid/os/Looper;

    move-result-object v3

    invoke-direct {v1, v3}, Landroid/os/Handler;-><init>(Landroid/os/Looper;)V

    .line 73
    invoke-static {p1, v2, v0, p2, v1}, Landroid/view/PixelCopy;->request(Landroid/view/Window;Landroid/graphics/Rect;Landroid/graphics/Bitmap;Landroid/view/PixelCopy$OnPixelCopyFinishedListener;Landroid/os/Handler;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 100
    new-instance p2, Ljava/lang/StringBuilder;

    const-string v0, "PixelCopy\u5f02\u5e38: "

    invoke-direct {p2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {p3, p1}, Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;->onError(Ljava/lang/String;)V

    goto :goto_0

    .line 105
    :cond_2
    :try_start_1
    invoke-virtual {p2}, Landroid/view/View;->getWidth()I

    move-result p1

    .line 106
    invoke-virtual {p2}, Landroid/view/View;->getHeight()I

    move-result v0

    int-to-float v1, p1

    const/high16 v2, 0x3f800000    # 1.0f

    mul-float/2addr v1, v2

    .line 107
    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    int-to-float v1, v0

    mul-float/2addr v1, v2

    .line 108
    invoke-static {v1}, Ljava/lang/Math;->round(F)I

    .line 109
    sget-object v1, Landroid/graphics/Bitmap$Config;->ARGB_8888:Landroid/graphics/Bitmap$Config;

    invoke-static {p1, v0, v1}, Landroid/graphics/Bitmap;->createBitmap(IILandroid/graphics/Bitmap$Config;)Landroid/graphics/Bitmap;

    move-result-object p1

    .line 110
    new-instance v0, Landroid/graphics/Canvas;

    invoke-direct {v0, p1}, Landroid/graphics/Canvas;-><init>(Landroid/graphics/Bitmap;)V

    const/4 v1, -0x1

    .line 111
    invoke-virtual {v0, v1}, Landroid/graphics/Canvas;->drawColor(I)V

    .line 112
    invoke-virtual {p2, v0}, Landroid/view/View;->draw(Landroid/graphics/Canvas;)V

    .line 122
    new-instance p2, Ljava/io/ByteArrayOutputStream;

    invoke-direct {p2}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 123
    sget-object v0, Landroid/graphics/Bitmap$CompressFormat;->JPEG:Landroid/graphics/Bitmap$CompressFormat;

    const/16 v1, 0x46

    invoke-virtual {p1, v0, v1, p2}, Landroid/graphics/Bitmap;->compress(Landroid/graphics/Bitmap$CompressFormat;ILjava/io/OutputStream;)Z

    move-result v0

    .line 124
    invoke-virtual {p1}, Landroid/graphics/Bitmap;->recycle()V

    if-eqz v0, :cond_3

    .line 126
    invoke-virtual {p2}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p1

    invoke-interface {p3, p1}, Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;->onSuccess([B)V

    goto :goto_0

    :cond_3
    const-string p1, "JPEG\u538b\u7f29\u5931\u8d25"

    .line 128
    invoke-interface {p3, p1}, Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;->onError(Ljava/lang/String;)V
    :try_end_1
    .catch Ljava/lang/Exception; {:try_start_1 .. :try_end_1} :catch_1

    goto :goto_0

    :catch_1
    move-exception p1

    .line 131
    new-instance p2, Ljava/lang/StringBuilder;

    const-string v0, "Canvas\u622a\u56fe\u5f02\u5e38: "

    invoke-direct {p2, v0}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {p3, p1}, Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;->onError(Ljava/lang/String;)V

    :goto_0
    return-void

    :cond_4
    :goto_1
    const-string p1, "View\u65e0\u6548"

    .line 58
    invoke-interface {p3, p1}, Lplugins/MultiScreenPlugin/CaptureOptimizer$PixelCopyCallback;->onError(Ljava/lang/String;)V

    return-void
.end method
