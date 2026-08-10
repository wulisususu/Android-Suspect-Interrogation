.class public final enum Lcom/google/android/gms/internal/mlkit_common/zzls;
.super Ljava/lang/Enum;
.source "com.google.mlkit:common@@18.9.0"

# interfaces
.implements Lcom/google/android/gms/internal/mlkit_common/zzbm;


# static fields
.field public static final enum zza:Lcom/google/android/gms/internal/mlkit_common/zzls;

.field public static final enum zzb:Lcom/google/android/gms/internal/mlkit_common/zzls;

.field public static final enum zzc:Lcom/google/android/gms/internal/mlkit_common/zzls;

.field public static final enum zzd:Lcom/google/android/gms/internal/mlkit_common/zzls;

.field public static final enum zze:Lcom/google/android/gms/internal/mlkit_common/zzls;

.field public static final enum zzf:Lcom/google/android/gms/internal/mlkit_common/zzls;

.field public static final enum zzg:Lcom/google/android/gms/internal/mlkit_common/zzls;

.field public static final enum zzh:Lcom/google/android/gms/internal/mlkit_common/zzls;

.field public static final enum zzi:Lcom/google/android/gms/internal/mlkit_common/zzls;

.field public static final enum zzj:Lcom/google/android/gms/internal/mlkit_common/zzls;

.field public static final enum zzk:Lcom/google/android/gms/internal/mlkit_common/zzls;

.field public static final enum zzl:Lcom/google/android/gms/internal/mlkit_common/zzls;

.field public static final enum zzm:Lcom/google/android/gms/internal/mlkit_common/zzls;

.field private static final synthetic zzn:[Lcom/google/android/gms/internal/mlkit_common/zzls;


# instance fields
.field private final zzo:I


# direct methods
.method static constructor <clinit>()V
    .locals 15

    .line 1
    new-instance v0, Lcom/google/android/gms/internal/mlkit_common/zzls;

    const-string v1, "UNKNOWN_STATUS"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2, v2}, Lcom/google/android/gms/internal/mlkit_common/zzls;-><init>(Ljava/lang/String;II)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_common/zzls;->zza:Lcom/google/android/gms/internal/mlkit_common/zzls;

    new-instance v1, Lcom/google/android/gms/internal/mlkit_common/zzls;

    const-string v2, "EXPLICITLY_REQUESTED"

    const/4 v3, 0x1

    .line 2
    invoke-direct {v1, v2, v3, v3}, Lcom/google/android/gms/internal/mlkit_common/zzls;-><init>(Ljava/lang/String;II)V

    sput-object v1, Lcom/google/android/gms/internal/mlkit_common/zzls;->zzb:Lcom/google/android/gms/internal/mlkit_common/zzls;

    new-instance v2, Lcom/google/android/gms/internal/mlkit_common/zzls;

    const-string v3, "IMPLICITLY_REQUESTED"

    const/4 v4, 0x2

    .line 3
    invoke-direct {v2, v3, v4, v4}, Lcom/google/android/gms/internal/mlkit_common/zzls;-><init>(Ljava/lang/String;II)V

    sput-object v2, Lcom/google/android/gms/internal/mlkit_common/zzls;->zzc:Lcom/google/android/gms/internal/mlkit_common/zzls;

    new-instance v3, Lcom/google/android/gms/internal/mlkit_common/zzls;

    const-string v4, "MODEL_INFO_RETRIEVAL_SUCCEEDED"

    const/4 v5, 0x3

    .line 4
    invoke-direct {v3, v4, v5, v5}, Lcom/google/android/gms/internal/mlkit_common/zzls;-><init>(Ljava/lang/String;II)V

    sput-object v3, Lcom/google/android/gms/internal/mlkit_common/zzls;->zzd:Lcom/google/android/gms/internal/mlkit_common/zzls;

    new-instance v4, Lcom/google/android/gms/internal/mlkit_common/zzls;

    const-string v5, "MODEL_INFO_RETRIEVAL_FAILED"

    const/4 v6, 0x4

    .line 5
    invoke-direct {v4, v5, v6, v6}, Lcom/google/android/gms/internal/mlkit_common/zzls;-><init>(Ljava/lang/String;II)V

    sput-object v4, Lcom/google/android/gms/internal/mlkit_common/zzls;->zze:Lcom/google/android/gms/internal/mlkit_common/zzls;

    new-instance v5, Lcom/google/android/gms/internal/mlkit_common/zzls;

    const-string v6, "SCHEDULED"

    const/4 v7, 0x5

    .line 6
    invoke-direct {v5, v6, v7, v7}, Lcom/google/android/gms/internal/mlkit_common/zzls;-><init>(Ljava/lang/String;II)V

    sput-object v5, Lcom/google/android/gms/internal/mlkit_common/zzls;->zzf:Lcom/google/android/gms/internal/mlkit_common/zzls;

    new-instance v6, Lcom/google/android/gms/internal/mlkit_common/zzls;

    const-string v7, "DOWNLOADING"

    const/4 v8, 0x6

    .line 7
    invoke-direct {v6, v7, v8, v8}, Lcom/google/android/gms/internal/mlkit_common/zzls;-><init>(Ljava/lang/String;II)V

    sput-object v6, Lcom/google/android/gms/internal/mlkit_common/zzls;->zzg:Lcom/google/android/gms/internal/mlkit_common/zzls;

    new-instance v7, Lcom/google/android/gms/internal/mlkit_common/zzls;

    const-string v8, "SUCCEEDED"

    const/4 v9, 0x7

    .line 8
    invoke-direct {v7, v8, v9, v9}, Lcom/google/android/gms/internal/mlkit_common/zzls;-><init>(Ljava/lang/String;II)V

    sput-object v7, Lcom/google/android/gms/internal/mlkit_common/zzls;->zzh:Lcom/google/android/gms/internal/mlkit_common/zzls;

    new-instance v8, Lcom/google/android/gms/internal/mlkit_common/zzls;

    const-string v9, "FAILED"

    const/16 v10, 0x8

    .line 9
    invoke-direct {v8, v9, v10, v10}, Lcom/google/android/gms/internal/mlkit_common/zzls;-><init>(Ljava/lang/String;II)V

    sput-object v8, Lcom/google/android/gms/internal/mlkit_common/zzls;->zzi:Lcom/google/android/gms/internal/mlkit_common/zzls;

    new-instance v9, Lcom/google/android/gms/internal/mlkit_common/zzls;

    const-string v10, "LIVE"

    const/16 v11, 0x9

    .line 10
    invoke-direct {v9, v10, v11, v11}, Lcom/google/android/gms/internal/mlkit_common/zzls;-><init>(Ljava/lang/String;II)V

    sput-object v9, Lcom/google/android/gms/internal/mlkit_common/zzls;->zzj:Lcom/google/android/gms/internal/mlkit_common/zzls;

    new-instance v10, Lcom/google/android/gms/internal/mlkit_common/zzls;

    const-string v11, "UPDATE_AVAILABLE"

    const/16 v12, 0xa

    .line 11
    invoke-direct {v10, v11, v12, v12}, Lcom/google/android/gms/internal/mlkit_common/zzls;-><init>(Ljava/lang/String;II)V

    sput-object v10, Lcom/google/android/gms/internal/mlkit_common/zzls;->zzk:Lcom/google/android/gms/internal/mlkit_common/zzls;

    new-instance v11, Lcom/google/android/gms/internal/mlkit_common/zzls;

    const-string v12, "DOWNLOADED"

    const/16 v13, 0xb

    .line 12
    invoke-direct {v11, v12, v13, v13}, Lcom/google/android/gms/internal/mlkit_common/zzls;-><init>(Ljava/lang/String;II)V

    sput-object v11, Lcom/google/android/gms/internal/mlkit_common/zzls;->zzl:Lcom/google/android/gms/internal/mlkit_common/zzls;

    new-instance v12, Lcom/google/android/gms/internal/mlkit_common/zzls;

    const-string v13, "STARTED"

    const/16 v14, 0xc

    .line 13
    invoke-direct {v12, v13, v14, v14}, Lcom/google/android/gms/internal/mlkit_common/zzls;-><init>(Ljava/lang/String;II)V

    sput-object v12, Lcom/google/android/gms/internal/mlkit_common/zzls;->zzm:Lcom/google/android/gms/internal/mlkit_common/zzls;

    filled-new-array/range {v0 .. v12}, [Lcom/google/android/gms/internal/mlkit_common/zzls;

    move-result-object v0

    sput-object v0, Lcom/google/android/gms/internal/mlkit_common/zzls;->zzn:[Lcom/google/android/gms/internal/mlkit_common/zzls;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;II)V
    .locals 0

    .line 1
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput p3, p0, Lcom/google/android/gms/internal/mlkit_common/zzls;->zzo:I

    return-void
.end method

.method public static values()[Lcom/google/android/gms/internal/mlkit_common/zzls;
    .locals 1

    sget-object v0, Lcom/google/android/gms/internal/mlkit_common/zzls;->zzn:[Lcom/google/android/gms/internal/mlkit_common/zzls;

    .line 1
    invoke-virtual {v0}, [Lcom/google/android/gms/internal/mlkit_common/zzls;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/google/android/gms/internal/mlkit_common/zzls;

    return-object v0
.end method


# virtual methods
.method public final zza()I
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/mlkit_common/zzls;->zzo:I

    return v0
.end method
