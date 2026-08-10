.class public final enum Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;
.super Ljava/lang/Enum;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.0"

# interfaces
.implements Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfe;


# static fields
.field public static final enum zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

.field public static final enum zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

.field public static final enum zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

.field public static final enum zzd:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

.field public static final enum zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

.field public static final enum zzf:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

.field public static final enum zzg:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

.field public static final enum zzh:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

.field public static final enum zzi:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

.field public static final enum zzj:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

.field public static final enum zzk:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

.field public static final enum zzl:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

.field public static final enum zzm:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

.field private static final synthetic zzn:[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;


# instance fields
.field private final zzo:I


# direct methods
.method static constructor <clinit>()V
    .locals 15

    .line 1
    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    const-string v1, "TYPE_UNKNOWN"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    new-instance v1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    const-string v2, "TYPE_CONTACT_INFO"

    const/4 v3, 0x1

    .line 2
    invoke-direct {v1, v2, v3, v3}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;-><init>(Ljava/lang/String;II)V

    sput-object v1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    new-instance v2, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    const-string v3, "TYPE_EMAIL"

    const/4 v4, 0x2

    .line 3
    invoke-direct {v2, v3, v4, v4}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;-><init>(Ljava/lang/String;II)V

    sput-object v2, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;->zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    new-instance v3, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    const-string v4, "TYPE_ISBN"

    const/4 v5, 0x3

    .line 4
    invoke-direct {v3, v4, v5, v5}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;-><init>(Ljava/lang/String;II)V

    sput-object v3, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;->zzd:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    new-instance v4, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    const-string v5, "TYPE_PHONE"

    const/4 v6, 0x4

    .line 5
    invoke-direct {v4, v5, v6, v6}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;-><init>(Ljava/lang/String;II)V

    sput-object v4, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;->zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    new-instance v5, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    const-string v6, "TYPE_PRODUCT"

    const/4 v7, 0x5

    .line 6
    invoke-direct {v5, v6, v7, v7}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;-><init>(Ljava/lang/String;II)V

    sput-object v5, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;->zzf:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    new-instance v6, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    const-string v7, "TYPE_SMS"

    const/4 v8, 0x6

    .line 7
    invoke-direct {v6, v7, v8, v8}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;-><init>(Ljava/lang/String;II)V

    sput-object v6, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;->zzg:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    new-instance v7, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    const-string v8, "TYPE_TEXT"

    const/4 v9, 0x7

    .line 8
    invoke-direct {v7, v8, v9, v9}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;-><init>(Ljava/lang/String;II)V

    sput-object v7, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;->zzh:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    new-instance v8, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    const-string v9, "TYPE_URL"

    const/16 v10, 0x8

    .line 9
    invoke-direct {v8, v9, v10, v10}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;-><init>(Ljava/lang/String;II)V

    sput-object v8, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;->zzi:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    new-instance v9, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    const-string v10, "TYPE_WIFI"

    const/16 v11, 0x9

    .line 10
    invoke-direct {v9, v10, v11, v11}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;-><init>(Ljava/lang/String;II)V

    sput-object v9, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;->zzj:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    new-instance v10, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    const-string v11, "TYPE_GEO"

    const/16 v12, 0xa

    .line 11
    invoke-direct {v10, v11, v12, v12}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;-><init>(Ljava/lang/String;II)V

    sput-object v10, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;->zzk:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    new-instance v11, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    const-string v12, "TYPE_CALENDAR_EVENT"

    const/16 v13, 0xb

    .line 12
    invoke-direct {v11, v12, v13, v13}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;-><init>(Ljava/lang/String;II)V

    sput-object v11, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;->zzl:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    new-instance v12, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    const-string v13, "TYPE_DRIVER_LICENSE"

    const/16 v14, 0xc

    .line 13
    invoke-direct {v12, v13, v14, v14}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;-><init>(Ljava/lang/String;II)V

    sput-object v12, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;->zzm:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    filled-new-array/range {v0 .. v12}, [Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;->zzn:[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput p3, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;->zzo:I

    return-void
.end method

.method public static values()[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;->zzn:[Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    .line 1
    invoke-virtual {v0}, [Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    return-object v0
.end method


# virtual methods
.method public final zza()I
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;->zzo:I

    return v0
.end method
