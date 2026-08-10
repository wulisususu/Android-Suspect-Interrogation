.class public final enum Lcom/google/android/gms/internal/mlkit_common/zzlx;
.super Ljava/lang/Enum;
.source "com.google.mlkit:common@@18.9.0"

# interfaces
.implements Lcom/google/android/gms/internal/mlkit_common/zzbm;


# static fields
.field public static final enum zza:Lcom/google/android/gms/internal/mlkit_common/zzlx;

.field public static final enum zzb:Lcom/google/android/gms/internal/mlkit_common/zzlx;

.field public static final enum zzc:Lcom/google/android/gms/internal/mlkit_common/zzlx;

.field public static final enum zzd:Lcom/google/android/gms/internal/mlkit_common/zzlx;

.field public static final enum zze:Lcom/google/android/gms/internal/mlkit_common/zzlx;

.field public static final enum zzf:Lcom/google/android/gms/internal/mlkit_common/zzlx;

.field private static final synthetic zzg:[Lcom/google/android/gms/internal/mlkit_common/zzlx;


# instance fields
.field private final zzh:I


# direct methods
.method static constructor <clinit>()V
    .locals 8

    .line 1
    new-instance v0, Lcom/google/android/gms/internal/mlkit_common/zzlx;

    const-string v1, "SOURCE_UNKNOWN"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_common/zzlx;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_common/zzlx;->zza:Lcom/google/android/gms/internal/mlkit_common/zzlx;

    new-instance v1, Lcom/google/android/gms/internal/mlkit_common/zzlx;

    const-string v2, "APP_ASSET"

    const/4 v3, 0x1

    .line 2
    invoke-direct {v1, v2, v3, v3}, Lcom/google/android/gms/internal/mlkit_common/zzlx;-><init>(Ljava/lang/String;II)V

    sput-object v1, Lcom/google/android/gms/internal/mlkit_common/zzlx;->zzb:Lcom/google/android/gms/internal/mlkit_common/zzlx;

    new-instance v2, Lcom/google/android/gms/internal/mlkit_common/zzlx;

    const-string v3, "LOCAL"

    const/4 v4, 0x2

    .line 3
    invoke-direct {v2, v3, v4, v4}, Lcom/google/android/gms/internal/mlkit_common/zzlx;-><init>(Ljava/lang/String;II)V

    sput-object v2, Lcom/google/android/gms/internal/mlkit_common/zzlx;->zzc:Lcom/google/android/gms/internal/mlkit_common/zzlx;

    new-instance v3, Lcom/google/android/gms/internal/mlkit_common/zzlx;

    const-string v4, "CLOUD"

    const/4 v5, 0x3

    .line 4
    invoke-direct {v3, v4, v5, v5}, Lcom/google/android/gms/internal/mlkit_common/zzlx;-><init>(Ljava/lang/String;II)V

    sput-object v3, Lcom/google/android/gms/internal/mlkit_common/zzlx;->zzd:Lcom/google/android/gms/internal/mlkit_common/zzlx;

    new-instance v4, Lcom/google/android/gms/internal/mlkit_common/zzlx;

    const-string v5, "SDK_BUILT_IN"

    const/4 v6, 0x4

    .line 5
    invoke-direct {v4, v5, v6, v6}, Lcom/google/android/gms/internal/mlkit_common/zzlx;-><init>(Ljava/lang/String;II)V

    sput-object v4, Lcom/google/android/gms/internal/mlkit_common/zzlx;->zze:Lcom/google/android/gms/internal/mlkit_common/zzlx;

    new-instance v5, Lcom/google/android/gms/internal/mlkit_common/zzlx;

    const-string v6, "URI"

    const/4 v7, 0x5

    .line 6
    invoke-direct {v5, v6, v7, v7}, Lcom/google/android/gms/internal/mlkit_common/zzlx;-><init>(Ljava/lang/String;II)V

    sput-object v5, Lcom/google/android/gms/internal/mlkit_common/zzlx;->zzf:Lcom/google/android/gms/internal/mlkit_common/zzlx;

    filled-new-array/range {v0 .. v5}, [Lcom/google/android/gms/internal/mlkit_common/zzlx;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/internal/mlkit_common/zzlx;->zzg:[Lcom/google/android/gms/internal/mlkit_common/zzlx;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput p3, p0, Lcom/google/android/gms/internal/mlkit_common/zzlx;->zzh:I

    return-void
.end method

.method public static values()[Lcom/google/android/gms/internal/mlkit_common/zzlx;
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/mlkit_common/zzlx;->zzg:[Lcom/google/android/gms/internal/mlkit_common/zzlx;

    .line 1
    invoke-virtual {v0}, [Lcom/google/android/gms/internal/mlkit_common/zzlx;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/google/android/gms/internal/mlkit_common/zzlx;

    return-object v0
.end method


# virtual methods
.method public final zza()I
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/mlkit_common/zzlx;->zzh:I

    return v0
.end method
