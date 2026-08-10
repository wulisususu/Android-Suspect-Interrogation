.class public final Lcom/google/photos/vision/barhopper/zzl;
.super Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzed;
.source "com.google.mlkit:barcode-scanning@@17.2.0"

# interfaces
.implements Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzfp;


# static fields
.field private static final zza:Lcom/google/photos/vision/barhopper/zzl;


# instance fields
.field private zzd:I

.field private zze:Ljava/lang/String;

.field private zzf:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzel;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    .line 1
    new-instance v0, Lcom/google/photos/vision/barhopper/zzl;

    invoke-direct {v0}, Lcom/google/photos/vision/barhopper/zzl;-><init>()V

    sput-object v0, Lcom/google/photos/vision/barhopper/zzl;->zza:Lcom/google/photos/vision/barhopper/zzl;

    const-class v1, Lcom/google/photos/vision/barhopper/zzl;

    .line 2
    invoke-static {v1, v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzed;->zzU(Ljava/lang/Class;Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzed;)V

    return-void
.end method

.method private constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzed;-><init>()V

    const-string v0, ""

    iput-object v0, p0, Lcom/google/photos/vision/barhopper/zzl;->zze:Ljava/lang/String;

    .line 2
    invoke-static {}, Lcom/google/photos/vision/barhopper/zzl;->zzO()Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzel;

    move-result-object v0

    iput-object v0, p0, Lcom/google/photos/vision/barhopper/zzl;->zzf:Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzel;

    return-void
.end method

.method static synthetic zza()Lcom/google/photos/vision/barhopper/zzl;
    .locals 1

    sget-object v0, Lcom/google/photos/vision/barhopper/zzl;->zza:Lcom/google/photos/vision/barhopper/zzl;

    return-object v0
.end method


# virtual methods
.method protected final zzg(ILjava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    add-int/lit8 p1, p1, -0x1

    if-eqz p1, :cond_4

    const/4 p2, 0x2

    if-eq p1, p2, :cond_3

    const/4 p2, 0x3

    if-eq p1, p2, :cond_2

    const/4 p2, 0x4

    const/4 p3, 0x0

    if-eq p1, p2, :cond_1

    const/4 p2, 0x5

    if-eq p1, p2, :cond_0

    return-object p3

    :cond_0
    sget-object p1, Lcom/google/photos/vision/barhopper/zzl;->zza:Lcom/google/photos/vision/barhopper/zzl;

    return-object p1

    .line 1
    :cond_1
    new-instance p1, Lcom/google/photos/vision/barhopper/zzk;

    .line 3
    invoke-direct {p1, p3}, Lcom/google/photos/vision/barhopper/zzk;-><init>(Lcom/google/photos/vision/barhopper/zza;)V

    return-object p1

    :cond_2
    new-instance p1, Lcom/google/photos/vision/barhopper/zzl;

    .line 4
    invoke-direct {p1}, Lcom/google/photos/vision/barhopper/zzl;-><init>()V

    return-object p1

    :cond_3
    const-string/jumbo p1, "zzf"

    .line 2
    const-class p2, Lcom/google/photos/vision/barhopper/zzaa;

    const-string/jumbo p3, "zzd"

    const-string/jumbo v0, "zze"

    filled-new-array {p3, v0, p1, p2}, [Ljava/lang/Object;

    move-result-object p1

    sget-object p2, Lcom/google/photos/vision/barhopper/zzl;->zza:Lcom/google/photos/vision/barhopper/zzl;

    const-string p3, "\u0001\u0002\u0000\u0001\u0001\u0002\u0002\u0000\u0001\u0000\u0001\u1008\u0000\u0002\u001b"

    invoke-static {p2, p3, p1}, Lcom/google/photos/vision/barhopper/zzl;->zzR(Lcom/google/android/gms/internal/mlkit_vision_barcode_bundled/zzfo;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    return-object p1

    :cond_4
    const/4 p1, 0x1

    .line 1
    invoke-static {p1}, Ljava/lang/Byte;->valueOf(B)Ljava/lang/Byte;

    move-result-object p1

    return-object p1
.end method
