.class public final Lcom/google/android/gms/internal/mlkit_common/zzql;
.super Ljava/lang/Object;
.source "com.google.mlkit:common@@18.9.0"


# static fields
.field private static final zza:Lcom/google/android/gms/common/internal/GmsLogger;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 1
    new-instance v0, Lcom/google/android/gms/common/internal/GmsLogger;

    const-string v1, "RemoteModelUtils"

    const-string v2, ""

    invoke-direct {v0, v1, v2}, Lcom/google/android/gms/common/internal/GmsLogger;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_common/zzql;->zza:Lcom/google/android/gms/common/internal/GmsLogger;

    return-void
.end method

.method public static zza(Lcom/google/mlkit/common/model/RemoteModel;Lcom/google/mlkit/common/sdkinternal/SharedPrefManager;Lcom/google/android/gms/internal/mlkit_common/zzqb;)Lcom/google/android/gms/internal/mlkit_common/zzlu;
    .locals 10

    .line 1
    invoke-virtual {p2}, Lcom/google/android/gms/internal/mlkit_common/zzqb;->zzb()Lcom/google/mlkit/common/sdkinternal/ModelType;

    move-result-object v0

    invoke-virtual {p0}, Lcom/google/mlkit/common/model/RemoteModel;->getModelHash()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Lcom/google/android/gms/internal/mlkit_common/zzma;

    invoke-direct {v2}, Lcom/google/android/gms/internal/mlkit_common/zzma;-><init>()V

    new-instance v3, Lcom/google/android/gms/internal/mlkit_common/zzlv;

    invoke-direct {v3}, Lcom/google/android/gms/internal/mlkit_common/zzlv;-><init>()V

    .line 2
    invoke-virtual {p0}, Lcom/google/mlkit/common/model/RemoteModel;->getModelNameForBackend()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Lcom/google/android/gms/internal/mlkit_common/zzlv;->zzc(Ljava/lang/String;)Lcom/google/android/gms/internal/mlkit_common/zzlv;

    sget-object v4, Lcom/google/android/gms/internal/mlkit_common/zzlx;->zzd:Lcom/google/android/gms/internal/mlkit_common/zzlx;

    .line 3
    invoke-virtual {v3, v4}, Lcom/google/android/gms/internal/mlkit_common/zzlv;->zzd(Lcom/google/android/gms/internal/mlkit_common/zzlx;)Lcom/google/android/gms/internal/mlkit_common/zzlv;

    .line 4
    invoke-static {v1}, Lcom/google/android/gms/internal/mlkit_common/zzag;->zzb(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v3, v1}, Lcom/google/android/gms/internal/mlkit_common/zzlv;->zza(Ljava/lang/String;)Lcom/google/android/gms/internal/mlkit_common/zzlv;

    .line 5
    invoke-virtual {v0}, Lcom/google/mlkit/common/sdkinternal/ModelType;->ordinal()I

    move-result v0

    const/4 v1, 0x2

    if-eq v0, v1, :cond_2

    const/4 v1, 0x4

    if-eq v0, v1, :cond_1

    const/4 v1, 0x5

    if-eq v0, v1, :cond_0

    .line 9
    sget-object v0, Lcom/google/android/gms/internal/mlkit_common/zzlw;->zza:Lcom/google/android/gms/internal/mlkit_common/zzlw;

    goto :goto_0

    .line 7
    :cond_0
    sget-object v0, Lcom/google/android/gms/internal/mlkit_common/zzlw;->zzh:Lcom/google/android/gms/internal/mlkit_common/zzlw;

    goto :goto_0

    .line 6
    :cond_1
    sget-object v0, Lcom/google/android/gms/internal/mlkit_common/zzlw;->zzb:Lcom/google/android/gms/internal/mlkit_common/zzlw;

    goto :goto_0

    .line 8
    :cond_2
    sget-object v0, Lcom/google/android/gms/internal/mlkit_common/zzlw;->zzd:Lcom/google/android/gms/internal/mlkit_common/zzlw;

    .line 10
    :goto_0
    invoke-virtual {v3, v0}, Lcom/google/android/gms/internal/mlkit_common/zzlv;->zzb(Lcom/google/android/gms/internal/mlkit_common/zzlw;)Lcom/google/android/gms/internal/mlkit_common/zzlv;

    invoke-virtual {v3}, Lcom/google/android/gms/internal/mlkit_common/zzlv;->zzg()Lcom/google/android/gms/internal/mlkit_common/zzlz;

    move-result-object v0

    .line 11
    invoke-virtual {v2, v0}, Lcom/google/android/gms/internal/mlkit_common/zzma;->zzb(Lcom/google/android/gms/internal/mlkit_common/zzlz;)Lcom/google/android/gms/internal/mlkit_common/zzma;

    invoke-virtual {v2}, Lcom/google/android/gms/internal/mlkit_common/zzma;->zzc()Lcom/google/android/gms/internal/mlkit_common/zzmd;

    move-result-object v0

    new-instance v1, Lcom/google/android/gms/internal/mlkit_common/zzlr;

    invoke-direct {v1}, Lcom/google/android/gms/internal/mlkit_common/zzlr;-><init>()V

    invoke-virtual {p2}, Lcom/google/android/gms/internal/mlkit_common/zzqb;->zzc()Lcom/google/android/gms/internal/mlkit_common/zzlm;

    move-result-object v2

    .line 12
    invoke-virtual {v1, v2}, Lcom/google/android/gms/internal/mlkit_common/zzlr;->zzd(Lcom/google/android/gms/internal/mlkit_common/zzlm;)Lcom/google/android/gms/internal/mlkit_common/zzlr;

    invoke-virtual {p2}, Lcom/google/android/gms/internal/mlkit_common/zzqb;->zzd()Lcom/google/android/gms/internal/mlkit_common/zzls;

    move-result-object v2

    .line 13
    invoke-virtual {v1, v2}, Lcom/google/android/gms/internal/mlkit_common/zzlr;->zzc(Lcom/google/android/gms/internal/mlkit_common/zzls;)Lcom/google/android/gms/internal/mlkit_common/zzlr;

    invoke-virtual {p2}, Lcom/google/android/gms/internal/mlkit_common/zzqb;->zza()I

    move-result v2

    int-to-long v2, v2

    .line 14
    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/google/android/gms/internal/mlkit_common/zzlr;->zzb(Ljava/lang/Long;)Lcom/google/android/gms/internal/mlkit_common/zzlr;

    .line 15
    invoke-virtual {v1, v0}, Lcom/google/android/gms/internal/mlkit_common/zzlr;->zzf(Lcom/google/android/gms/internal/mlkit_common/zzmd;)Lcom/google/android/gms/internal/mlkit_common/zzlr;

    invoke-virtual {p2}, Lcom/google/android/gms/internal/mlkit_common/zzqb;->zzg()Z

    move-result v0

    const-string v2, "Model downloaded without its beginning time recorded."

    const-string v3, "RemoteModelUtils"

    const-wide/16 v4, 0x0

    if-eqz v0, :cond_5

    .line 16
    invoke-virtual {p1, p0}, Lcom/google/mlkit/common/sdkinternal/SharedPrefManager;->getModelDownloadBeginTimeMs(Lcom/google/mlkit/common/model/RemoteModel;)J

    move-result-wide v6

    cmp-long v0, v6, v4

    if-nez v0, :cond_3

    sget-object v0, Lcom/google/android/gms/internal/mlkit_common/zzql;->zza:Lcom/google/android/gms/common/internal/GmsLogger;

    .line 17
    invoke-virtual {v0, v3, v2}, Lcom/google/android/gms/common/internal/GmsLogger;->w(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_1

    .line 18
    :cond_3
    invoke-virtual {p1, p0}, Lcom/google/mlkit/common/sdkinternal/SharedPrefManager;->getModelFirstUseTimeMs(Lcom/google/mlkit/common/model/RemoteModel;)J

    move-result-wide v8

    cmp-long v0, v8, v4

    if-nez v0, :cond_4

    .line 19
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v8

    .line 20
    invoke-virtual {p1, p0, v8, v9}, Lcom/google/mlkit/common/sdkinternal/SharedPrefManager;->setModelFirstUseTimeMs(Lcom/google/mlkit/common/model/RemoteModel;J)V

    :cond_4
    sub-long/2addr v8, v6

    .line 21
    invoke-static {v8, v9}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/google/android/gms/internal/mlkit_common/zzlr;->zzg(Ljava/lang/Long;)Lcom/google/android/gms/internal/mlkit_common/zzlr;

    .line 17
    :cond_5
    :goto_1
    invoke-virtual {p2}, Lcom/google/android/gms/internal/mlkit_common/zzqb;->zzf()Z

    move-result p2

    if-eqz p2, :cond_7

    .line 22
    invoke-virtual {p1, p0}, Lcom/google/mlkit/common/sdkinternal/SharedPrefManager;->getModelDownloadBeginTimeMs(Lcom/google/mlkit/common/model/RemoteModel;)J

    move-result-wide p0

    cmp-long p2, p0, v4

    if-nez p2, :cond_6

    sget-object p0, Lcom/google/android/gms/internal/mlkit_common/zzql;->zza:Lcom/google/android/gms/common/internal/GmsLogger;

    .line 23
    invoke-virtual {p0, v3, v2}, Lcom/google/android/gms/common/internal/GmsLogger;->w(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_2

    .line 24
    :cond_6
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v2

    sub-long/2addr v2, p0

    .line 25
    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p0

    invoke-virtual {v1, p0}, Lcom/google/android/gms/internal/mlkit_common/zzlr;->zze(Ljava/lang/Long;)Lcom/google/android/gms/internal/mlkit_common/zzlr;

    .line 23
    :cond_7
    :goto_2
    invoke-virtual {v1}, Lcom/google/android/gms/internal/mlkit_common/zzlr;->zzi()Lcom/google/android/gms/internal/mlkit_common/zzlu;

    move-result-object p0

    return-object p0
.end method
