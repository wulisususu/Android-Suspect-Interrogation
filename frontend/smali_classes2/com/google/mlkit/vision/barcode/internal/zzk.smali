.class public final Lcom/google/mlkit/vision/barcode/internal/zzk;
.super Lcom/google/mlkit/common/sdkinternal/MLTask;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.0"


# static fields
.field static zza:Z

.field private static final zzb:Lcom/google/mlkit/vision/common/internal/ImageUtils;


# instance fields
.field private final zzc:Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;

.field private final zzd:Lcom/google/mlkit/vision/barcode/internal/zzl;

.field private final zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;

.field private final zzf:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztz;

.field private final zzg:Lcom/google/mlkit/vision/common/internal/BitmapInStreamingChecker;

.field private zzh:Z


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    invoke-static {}, Lcom/google/mlkit/vision/common/internal/ImageUtils;->getInstance()Lcom/google/mlkit/vision/common/internal/ImageUtils;

    move-result-object v0

    sput-object v0, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzb:Lcom/google/mlkit/vision/common/internal/ImageUtils;

    const/4 v0, 0x1

    sput-boolean v0, Lcom/google/mlkit/vision/barcode/internal/zzk;->zza:Z

    return-void
.end method

.method public constructor <init>(Lcom/google/mlkit/common/sdkinternal/MlKitContext;Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;Lcom/google/mlkit/vision/barcode/internal/zzl;Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;)V
    .locals 1

    .line 1
    invoke-direct {p0}, Lcom/google/mlkit/common/sdkinternal/MLTask;-><init>()V

    .line 2
    new-instance v0, Lcom/google/mlkit/vision/common/internal/BitmapInStreamingChecker;

    invoke-direct {v0}, Lcom/google/mlkit/vision/common/internal/BitmapInStreamingChecker;-><init>()V

    iput-object v0, p0, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzg:Lcom/google/mlkit/vision/common/internal/BitmapInStreamingChecker;

    const-string v0, "MlKitContext can not be null"

    .line 3
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "BarcodeScannerOptions can not be null"

    .line 4
    invoke-static {p2, v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    iput-object p2, p0, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzc:Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;

    iput-object p3, p0, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzd:Lcom/google/mlkit/vision/barcode/internal/zzl;

    iput-object p4, p0, Lcom/google/mlkit/vision/barcode/internal/zzk;->zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;

    .line 5
    invoke-virtual {p1}, Lcom/google/mlkit/common/sdkinternal/MlKitContext;->getApplicationContext()Landroid/content/Context;

    move-result-object p1

    invoke-static {p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztz;->zza(Landroid/content/Context;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zztz;

    move-result-object p1

    iput-object p1, p0, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzf:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztz;

    return-void
.end method

.method private final zzf(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpj;JLcom/google/mlkit/vision/common/InputImage;Ljava/util/List;)V
    .locals 27

    move-object/from16 v8, p0

    .line 1
    new-instance v9, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;

    invoke-direct {v9}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;-><init>()V

    new-instance v10, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;

    .line 2
    invoke-direct {v10}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;-><init>()V

    if-eqz p5, :cond_0

    .line 3
    invoke-interface/range {p5 .. p5}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/google/mlkit/vision/barcode/common/Barcode;

    .line 4
    invoke-virtual {v1}, Lcom/google/mlkit/vision/barcode/common/Barcode;->getFormat()I

    move-result v2

    invoke-static {v2}, Lcom/google/mlkit/vision/barcode/internal/zzb;->zza(I)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpv;

    move-result-object v2

    invoke-virtual {v9, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;->zzd(Ljava/lang/Object;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;

    .line 5
    invoke-virtual {v1}, Lcom/google/mlkit/vision/barcode/common/Barcode;->getValueType()I

    move-result v1

    invoke-static {v1}, Lcom/google/mlkit/vision/barcode/internal/zzb;->zzb(I)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpw;

    move-result-object v1

    invoke-virtual {v10, v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;->zzd(Ljava/lang/Object;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;

    goto :goto_0

    .line 6
    :cond_0
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v0

    sub-long v18, v0, p2

    new-instance v11, Lcom/google/mlkit/vision/barcode/internal/zzi;

    move-object v0, v11

    move-object/from16 v1, p0

    move-wide/from16 v2, v18

    move-object/from16 v4, p1

    move-object v5, v9

    move-object v6, v10

    move-object/from16 v7, p4

    invoke-direct/range {v0 .. v7}, Lcom/google/mlkit/vision/barcode/internal/zzi;-><init>(Lcom/google/mlkit/vision/barcode/internal/zzk;JLcom/google/android/gms/internal/mlkit_vision_barcode/zzpj;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;Lcom/google/mlkit/vision/common/InputImage;)V

    iget-object v0, v8, Lcom/google/mlkit/vision/barcode/internal/zzk;->zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;

    .line 7
    sget-object v1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;->zzj:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;

    invoke-virtual {v0, v11, v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;->zzf(Lcom/google/android/gms/internal/mlkit_vision_barcode/zztw;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;)V

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzft;

    invoke-direct {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzft;-><init>()V

    move-object/from16 v1, p1

    .line 8
    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzft;->zze(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpj;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzft;

    sget-boolean v2, Lcom/google/mlkit/vision/barcode/internal/zzk;->zza:Z

    .line 9
    invoke-static {v2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzft;->zzf(Ljava/lang/Boolean;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzft;

    iget-object v2, v8, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzc:Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;

    .line 10
    invoke-static {v2}, Lcom/google/mlkit/vision/barcode/internal/zzb;->zzc(Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzth;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzft;->zzg(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzth;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzft;

    .line 11
    invoke-virtual {v9}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;->zzf()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcv;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzft;->zzc(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcv;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzft;

    .line 12
    invoke-virtual {v10}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;->zzf()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcv;

    move-result-object v2

    invoke-virtual {v0, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzft;->zzd(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcv;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzft;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzft;->zzh()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfv;

    move-result-object v14

    new-instance v0, Lcom/google/mlkit/vision/barcode/internal/zzj;

    invoke-direct {v0, v8}, Lcom/google/mlkit/vision/barcode/internal/zzj;-><init>(Lcom/google/mlkit/vision/barcode/internal/zzk;)V

    iget-object v12, v8, Lcom/google/mlkit/vision/barcode/internal/zzk;->zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;

    sget-object v13, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;->zzbe:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;

    .line 13
    invoke-static {}, Lcom/google/mlkit/common/sdkinternal/MLTaskExecutor;->workerThreadExecutor()Ljava/util/concurrent/Executor;

    move-result-object v2

    new-instance v3, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztu;

    move-object v11, v3

    move-wide/from16 v15, v18

    move-object/from16 v17, v0

    invoke-direct/range {v11 .. v17}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztu;-><init>(Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;Ljava/lang/Object;JLcom/google/mlkit/vision/barcode/internal/zzj;)V

    .line 14
    invoke-interface {v2, v3}, Ljava/util/concurrent/Executor;->execute(Ljava/lang/Runnable;)V

    .line 15
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v25

    iget-boolean v0, v8, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzh:Z

    sub-long v23, v25, v18

    iget-object v2, v8, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzf:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztz;

    const/4 v3, 0x1

    if-eq v3, v0, :cond_1

    const/16 v0, 0x5eed

    goto :goto_1

    :cond_1
    const/16 v0, 0x5eee

    :goto_1
    move/from16 v21, v0

    .line 16
    invoke-virtual/range {p1 .. p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpj;->zza()I

    move-result v22

    move-object/from16 v20, v2

    .line 17
    invoke-virtual/range {v20 .. v26}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztz;->zzc(IIJJ)V

    return-void
.end method


# virtual methods
.method public final declared-synchronized load()V
    .locals 1
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/mlkit/common/MlKitException;
        }
    .end annotation

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzd:Lcom/google/mlkit/vision/barcode/internal/zzl;

    .line 1
    invoke-interface {v0}, Lcom/google/mlkit/vision/barcode/internal/zzl;->zzc()Z

    move-result v0

    iput-boolean v0, p0, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzh:Z
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final declared-synchronized release()V
    .locals 4

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzd:Lcom/google/mlkit/vision/barcode/internal/zzl;

    .line 1
    invoke-interface {v0}, Lcom/google/mlkit/vision/barcode/internal/zzl;->zzb()V

    const/4 v0, 0x1

    sput-boolean v0, Lcom/google/mlkit/vision/barcode/internal/zzk;->zza:Z

    iget-object v0, p0, Lcom/google/mlkit/vision/barcode/internal/zzk;->zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;

    new-instance v1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;

    invoke-direct {v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;-><init>()V

    iget-boolean v2, p0, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzh:Z

    if-eqz v2, :cond_0

    .line 2
    sget-object v2, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;->zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

    goto :goto_0

    :cond_0
    sget-object v2, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

    :goto_0
    invoke-virtual {v1, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;->zze(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;

    new-instance v2, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;

    invoke-direct {v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;-><init>()V

    iget-object v3, p0, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzc:Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;

    .line 3
    invoke-static {v3}, Lcom/google/mlkit/vision/barcode/internal/zzb;->zzc(Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzth;

    move-result-object v3

    invoke-virtual {v2, v3}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;->zzi(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzth;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;

    invoke-virtual {v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;->zzj()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpz;

    move-result-object v2

    .line 4
    invoke-virtual {v1, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;->zzg(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpz;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;

    .line 5
    invoke-static {v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzua;->zzf(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zztm;

    move-result-object v1

    sget-object v2, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;->zzl:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;

    .line 6
    invoke-virtual {v0, v1, v2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zztx;->zzd(Lcom/google/android/gms/internal/mlkit_vision_barcode/zztm;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpk;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public final bridge synthetic run(Lcom/google/mlkit/common/sdkinternal/MLTaskInput;)Ljava/lang/Object;
    .locals 0
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/mlkit/common/MlKitException;
        }
    .end annotation

    .line 1
    check-cast p1, Lcom/google/mlkit/vision/common/InputImage;

    invoke-virtual {p0, p1}, Lcom/google/mlkit/vision/barcode/internal/zzk;->zze(Lcom/google/mlkit/vision/common/InputImage;)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method final synthetic zzc(JLcom/google/android/gms/internal/mlkit_vision_barcode/zzpj;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;Lcom/google/mlkit/vision/common/InputImage;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zztm;
    .locals 2

    .line 1
    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;

    invoke-direct {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;-><init>()V

    new-instance v1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzow;

    invoke-direct {v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzow;-><init>()V

    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    invoke-virtual {v1, p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzow;->zzc(Ljava/lang/Long;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzow;

    .line 2
    invoke-virtual {v1, p3}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzow;->zzd(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpj;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzow;

    sget-boolean p1, Lcom/google/mlkit/vision/barcode/internal/zzk;->zza:Z

    .line 3
    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    invoke-virtual {v1, p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzow;->zze(Ljava/lang/Boolean;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzow;

    const/4 p1, 0x1

    .line 4
    invoke-static {p1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p1

    invoke-virtual {v1, p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzow;->zza(Ljava/lang/Boolean;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzow;

    .line 5
    invoke-virtual {v1, p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzow;->zzb(Ljava/lang/Boolean;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzow;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzow;->zzf()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoy;

    move-result-object p1

    .line 6
    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;->zzh(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoy;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;

    iget-object p1, p0, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzc:Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;

    .line 7
    invoke-static {p1}, Lcom/google/mlkit/vision/barcode/internal/zzb;->zzc(Lcom/google/mlkit/vision/barcode/BarcodeScannerOptions;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzth;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;->zzi(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzth;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;

    .line 8
    invoke-virtual {p4}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;->zzf()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcv;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;->zze(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcv;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;

    .line 9
    invoke-virtual {p5}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcs;->zzf()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcv;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;->zzf(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzcv;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;

    .line 10
    invoke-virtual {p6}, Lcom/google/mlkit/vision/common/InputImage;->getFormat()I

    move-result p1

    sget-object p2, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzb:Lcom/google/mlkit/vision/common/internal/ImageUtils;

    invoke-virtual {p2, p6}, Lcom/google/mlkit/vision/common/internal/ImageUtils;->getMobileVisionImageSize(Lcom/google/mlkit/vision/common/InputImage;)I

    move-result p2

    new-instance p3, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzop;

    invoke-direct {p3}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzop;-><init>()V

    const/4 p4, -0x1

    if-eq p1, p4, :cond_4

    const/16 p4, 0x23

    if-eq p1, p4, :cond_3

    const p4, 0x32315659

    if-eq p1, p4, :cond_2

    const/16 p4, 0x10

    if-eq p1, p4, :cond_1

    const/16 p4, 0x11

    if-eq p1, p4, :cond_0

    .line 16
    sget-object p1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    goto :goto_0

    .line 13
    :cond_0
    sget-object p1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;->zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    goto :goto_0

    .line 14
    :cond_1
    sget-object p1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    goto :goto_0

    .line 11
    :cond_2
    sget-object p1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;->zzd:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    goto :goto_0

    .line 12
    :cond_3
    sget-object p1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;->zze:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    goto :goto_0

    .line 15
    :cond_4
    sget-object p1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;->zzg:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;

    .line 17
    :goto_0
    invoke-virtual {p3, p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzop;->zza(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzoq;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzop;

    .line 18
    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p1

    invoke-virtual {p3, p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzop;->zzb(Ljava/lang/Integer;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzop;

    invoke-virtual {p3}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzop;->zzd()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzos;

    move-result-object p1

    .line 19
    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;->zzg(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzos;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;

    new-instance p1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;

    invoke-direct {p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;-><init>()V

    iget-boolean p2, p0, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzh:Z

    if-eqz p2, :cond_5

    .line 20
    sget-object p2, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;->zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

    goto :goto_1

    :cond_5
    sget-object p2, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

    :goto_1
    invoke-virtual {p1, p2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;->zze(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;

    invoke-virtual {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpx;->zzj()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpz;

    move-result-object p2

    .line 21
    invoke-virtual {p1, p2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;->zzg(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpz;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;

    .line 22
    invoke-static {p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzua;->zzf(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zztm;

    move-result-object p1

    return-object p1
.end method

.method final synthetic zzd(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfv;ILcom/google/android/gms/internal/mlkit_vision_barcode/zzol;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zztm;
    .locals 2

    .line 1
    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;

    invoke-direct {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;-><init>()V

    iget-boolean v1, p0, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzh:Z

    if-eqz v1, :cond_0

    sget-object v1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;->zzc:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

    goto :goto_0

    :cond_0
    sget-object v1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;->zzb:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;

    :goto_0
    invoke-virtual {v0, v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;->zze(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpi;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;

    new-instance v1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfs;

    invoke-direct {v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfs;-><init>()V

    .line 2
    invoke-static {p2}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object p2

    invoke-virtual {v1, p2}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfs;->zza(Ljava/lang/Integer;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfs;

    .line 3
    invoke-virtual {v1, p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfs;->zzc(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfv;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfs;

    .line 4
    invoke-virtual {v1, p3}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfs;->zzb(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzol;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfs;

    invoke-virtual {v1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfs;->zze()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfx;

    move-result-object p1

    .line 5
    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;->zzd(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzfx;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;

    .line 6
    invoke-static {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzua;->zzf(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpl;)Lcom/google/android/gms/internal/mlkit_vision_barcode/zztm;

    move-result-object p1

    return-object p1
.end method

.method public final declared-synchronized zze(Lcom/google/mlkit/vision/common/InputImage;)Ljava/util/List;
    .locals 9
    .annotation system Ldalvik/annotation/Throws;
        value = {
            Lcom/google/mlkit/common/MlKitException;
        }
    .end annotation

    monitor-enter p0

    .line 1
    :try_start_0
    invoke-static {}, Landroid/os/SystemClock;->elapsedRealtime()J

    move-result-wide v6

    iget-object v0, p0, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzg:Lcom/google/mlkit/vision/common/internal/BitmapInStreamingChecker;

    .line 2
    invoke-virtual {v0, p1}, Lcom/google/mlkit/vision/common/internal/BitmapInStreamingChecker;->check(Lcom/google/mlkit/vision/common/InputImage;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    :try_start_1
    iget-object v0, p0, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzd:Lcom/google/mlkit/vision/barcode/internal/zzl;

    .line 3
    invoke-interface {v0, p1}, Lcom/google/mlkit/vision/barcode/internal/zzl;->zza(Lcom/google/mlkit/vision/common/InputImage;)Ljava/util/List;

    move-result-object v8

    .line 4
    sget-object v1, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpj;->zza:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpj;

    move-object v0, p0

    move-wide v2, v6

    move-object v4, p1

    move-object v5, v8

    invoke-direct/range {v0 .. v5}, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzf(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpj;JLcom/google/mlkit/vision/common/InputImage;Ljava/util/List;)V

    const/4 v0, 0x0

    sput-boolean v0, Lcom/google/mlkit/vision/barcode/internal/zzk;->zza:Z
    :try_end_1
    .catch Lcom/google/mlkit/common/MlKitException; {:try_start_1 .. :try_end_1} :catch_0
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    monitor-exit p0

    return-object v8

    :catch_0
    move-exception v0

    move-object v8, v0

    .line 5
    :try_start_2
    invoke-virtual {v8}, Lcom/google/mlkit/common/MlKitException;->getErrorCode()I

    move-result v0

    const/16 v1, 0xe

    if-ne v0, v1, :cond_0

    .line 6
    sget-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpj;->zzk:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpj;

    goto :goto_0

    .line 7
    :cond_0
    sget-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpj;->zzX:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpj;

    :goto_0
    move-object v1, v0

    const/4 v5, 0x0

    move-object v0, p0

    move-wide v2, v6

    move-object v4, p1

    .line 8
    invoke-direct/range {v0 .. v5}, Lcom/google/mlkit/vision/barcode/internal/zzk;->zzf(Lcom/google/android/gms/internal/mlkit_vision_barcode/zzpj;JLcom/google/mlkit/vision/common/InputImage;Ljava/util/List;)V

    .line 9
    throw v8
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    :catchall_0
    move-exception p1

    monitor-exit p0

    throw p1
.end method
