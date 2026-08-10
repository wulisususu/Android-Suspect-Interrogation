.class public final Lcom/google/android/gms/internal/mlkit_common/zzlr;
.super Ljava/lang/Object;
.source "com.google.mlkit:common@@18.9.0"


# instance fields
.field private zza:Lcom/google/android/gms/internal/mlkit_common/zzmd;

.field private zzb:Ljava/lang/Long;

.field private zzc:Lcom/google/android/gms/internal/mlkit_common/zzlm;

.field private zzd:Ljava/lang/Long;

.field private zze:Lcom/google/android/gms/internal/mlkit_common/zzls;

.field private zzf:Ljava/lang/Long;


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method static bridge synthetic zza(Lcom/google/android/gms/internal/mlkit_common/zzlr;)Lcom/google/android/gms/internal/mlkit_common/zzlm;
    .locals 0

    iget-object p0, p0, Lcom/google/android/gms/internal/mlkit_common/zzlr;->zzc:Lcom/google/android/gms/internal/mlkit_common/zzlm;

    return-object p0
.end method

.method static bridge synthetic zzh(Lcom/google/android/gms/internal/mlkit_common/zzlr;)Lcom/google/android/gms/internal/mlkit_common/zzls;
    .locals 0

    iget-object p0, p0, Lcom/google/android/gms/internal/mlkit_common/zzlr;->zze:Lcom/google/android/gms/internal/mlkit_common/zzls;

    return-object p0
.end method

.method static bridge synthetic zzj(Lcom/google/android/gms/internal/mlkit_common/zzlr;)Lcom/google/android/gms/internal/mlkit_common/zzmd;
    .locals 0

    iget-object p0, p0, Lcom/google/android/gms/internal/mlkit_common/zzlr;->zza:Lcom/google/android/gms/internal/mlkit_common/zzmd;

    return-object p0
.end method

.method static bridge synthetic zzk(Lcom/google/android/gms/internal/mlkit_common/zzlr;)Ljava/lang/Long;
    .locals 0

    iget-object p0, p0, Lcom/google/android/gms/internal/mlkit_common/zzlr;->zzf:Ljava/lang/Long;

    return-object p0
.end method

.method static bridge synthetic zzl(Lcom/google/android/gms/internal/mlkit_common/zzlr;)Ljava/lang/Long;
    .locals 0

    iget-object p0, p0, Lcom/google/android/gms/internal/mlkit_common/zzlr;->zzd:Ljava/lang/Long;

    return-object p0
.end method

.method static bridge synthetic zzm(Lcom/google/android/gms/internal/mlkit_common/zzlr;)Ljava/lang/Long;
    .locals 0

    iget-object p0, p0, Lcom/google/android/gms/internal/mlkit_common/zzlr;->zzb:Ljava/lang/Long;

    return-object p0
.end method


# virtual methods
.method public final zzb(Ljava/lang/Long;)Lcom/google/android/gms/internal/mlkit_common/zzlr;
    .locals 0

    iput-object p1, p0, Lcom/google/android/gms/internal/mlkit_common/zzlr;->zzf:Ljava/lang/Long;

    return-object p0
.end method

.method public final zzc(Lcom/google/android/gms/internal/mlkit_common/zzls;)Lcom/google/android/gms/internal/mlkit_common/zzlr;
    .locals 0

    iput-object p1, p0, Lcom/google/android/gms/internal/mlkit_common/zzlr;->zze:Lcom/google/android/gms/internal/mlkit_common/zzls;

    return-object p0
.end method

.method public final zzd(Lcom/google/android/gms/internal/mlkit_common/zzlm;)Lcom/google/android/gms/internal/mlkit_common/zzlr;
    .locals 0

    iput-object p1, p0, Lcom/google/android/gms/internal/mlkit_common/zzlr;->zzc:Lcom/google/android/gms/internal/mlkit_common/zzlm;

    return-object p0
.end method

.method public final zze(Ljava/lang/Long;)Lcom/google/android/gms/internal/mlkit_common/zzlr;
    .locals 4

    .line 1
    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    const-wide v2, 0x7fffffffffffffffL

    and-long/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    iput-object p1, p0, Lcom/google/android/gms/internal/mlkit_common/zzlr;->zzd:Ljava/lang/Long;

    return-object p0
.end method

.method public final zzf(Lcom/google/android/gms/internal/mlkit_common/zzmd;)Lcom/google/android/gms/internal/mlkit_common/zzlr;
    .locals 0

    iput-object p1, p0, Lcom/google/android/gms/internal/mlkit_common/zzlr;->zza:Lcom/google/android/gms/internal/mlkit_common/zzmd;

    return-object p0
.end method

.method public final zzg(Ljava/lang/Long;)Lcom/google/android/gms/internal/mlkit_common/zzlr;
    .locals 4

    .line 1
    invoke-virtual {p1}, Ljava/lang/Long;->longValue()J

    move-result-wide v0

    const-wide v2, 0x7fffffffffffffffL

    and-long/2addr v0, v2

    invoke-static {v0, v1}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    iput-object p1, p0, Lcom/google/android/gms/internal/mlkit_common/zzlr;->zzb:Ljava/lang/Long;

    return-object p0
.end method

.method public final zzi()Lcom/google/android/gms/internal/mlkit_common/zzlu;
    .locals 2

    new-instance v0, Lcom/google/android/gms/internal/mlkit_common/zzlu;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/google/android/gms/internal/mlkit_common/zzlu;-><init>(Lcom/google/android/gms/internal/mlkit_common/zzlr;Lcom/google/android/gms/internal/mlkit_common/zzlt;)V

    return-object v0
.end method
