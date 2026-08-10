.class public final Lcom/google/android/gms/internal/mlkit_common/zzqc;
.super Ljava/lang/Object;
.source "com.google.mlkit:common@@18.9.0"

# interfaces
.implements Lcom/google/android/gms/internal/mlkit_common/zzpq;


# instance fields
.field private final zza:Lcom/google/android/gms/internal/mlkit_common/zzlo;

.field private zzb:Lcom/google/android/gms/internal/mlkit_common/zzol;


# direct methods
.method private constructor <init>(Lcom/google/android/gms/internal/mlkit_common/zzlo;I)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance p2, Lcom/google/android/gms/internal/mlkit_common/zzol;

    invoke-direct {p2}, Lcom/google/android/gms/internal/mlkit_common/zzol;-><init>()V

    iput-object p2, p0, Lcom/google/android/gms/internal/mlkit_common/zzqc;->zzb:Lcom/google/android/gms/internal/mlkit_common/zzol;

    iput-object p1, p0, Lcom/google/android/gms/internal/mlkit_common/zzqc;->zza:Lcom/google/android/gms/internal/mlkit_common/zzlo;

    invoke-static {}, Lcom/google/android/gms/internal/mlkit_common/zzqn;->zza()Lcom/google/android/gms/internal/mlkit_common/zzqn;

    return-void
.end method

.method public static zzf(Lcom/google/android/gms/internal/mlkit_common/zzlo;)Lcom/google/android/gms/internal/mlkit_common/zzpq;
    .locals 2

    .line 1
    new-instance v0, Lcom/google/android/gms/internal/mlkit_common/zzqc;

    const/4 v1, 0x0

    invoke-direct {v0, p0, v1}, Lcom/google/android/gms/internal/mlkit_common/zzqc;-><init>(Lcom/google/android/gms/internal/mlkit_common/zzlo;I)V

    return-object v0
.end method

.method public static zzg()Lcom/google/android/gms/internal/mlkit_common/zzpq;
    .locals 3

    .line 1
    new-instance v0, Lcom/google/android/gms/internal/mlkit_common/zzqc;

    new-instance v1, Lcom/google/android/gms/internal/mlkit_common/zzlo;

    invoke-direct {v1}, Lcom/google/android/gms/internal/mlkit_common/zzlo;-><init>()V

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/google/android/gms/internal/mlkit_common/zzqc;-><init>(Lcom/google/android/gms/internal/mlkit_common/zzlo;I)V

    return-object v0
.end method


# virtual methods
.method public final zza(Lcom/google/android/gms/internal/mlkit_common/zzln;)Lcom/google/android/gms/internal/mlkit_common/zzpq;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_common/zzqc;->zza:Lcom/google/android/gms/internal/mlkit_common/zzlo;

    .line 1
    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/mlkit_common/zzlo;->zzf(Lcom/google/android/gms/internal/mlkit_common/zzln;)Lcom/google/android/gms/internal/mlkit_common/zzlo;

    return-object p0
.end method

.method public final zzb(Lcom/google/android/gms/internal/mlkit_common/zzlu;)Lcom/google/android/gms/internal/mlkit_common/zzpq;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_common/zzqc;->zza:Lcom/google/android/gms/internal/mlkit_common/zzlo;

    .line 1
    invoke-virtual {v0, p1}, Lcom/google/android/gms/internal/mlkit_common/zzlo;->zzi(Lcom/google/android/gms/internal/mlkit_common/zzlu;)Lcom/google/android/gms/internal/mlkit_common/zzlo;

    return-object p0
.end method

.method public final zzc(Lcom/google/android/gms/internal/mlkit_common/zzol;)Lcom/google/android/gms/internal/mlkit_common/zzpq;
    .locals 0

    iput-object p1, p0, Lcom/google/android/gms/internal/mlkit_common/zzqc;->zzb:Lcom/google/android/gms/internal/mlkit_common/zzol;

    return-object p0
.end method

.method public final zzd()Ljava/lang/String;
    .locals 2

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_common/zzqc;->zza:Lcom/google/android/gms/internal/mlkit_common/zzlo;

    .line 1
    invoke-virtual {v0}, Lcom/google/android/gms/internal/mlkit_common/zzlo;->zzk()Lcom/google/android/gms/internal/mlkit_common/zzlq;

    move-result-object v0

    invoke-virtual {v0}, Lcom/google/android/gms/internal/mlkit_common/zzlq;->zzf()Lcom/google/android/gms/internal/mlkit_common/zzon;

    move-result-object v0

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/google/android/gms/internal/mlkit_common/zzon;->zzk()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/google/android/gms/internal/mlkit_common/zzag;->zzc(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    invoke-virtual {v0}, Lcom/google/android/gms/internal/mlkit_common/zzon;->zzk()Ljava/lang/String;

    move-result-object v0

    .line 2
    invoke-static {v0}, Lcom/google/android/gms/common/internal/Preconditions;->checkNotNull(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/String;

    return-object v0

    :cond_0
    const-string v0, "NA"

    return-object v0
.end method

.method public final zze(IZ)[B
    .locals 3

    xor-int/lit8 p2, p1, 0x1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_common/zzqc;->zzb:Lcom/google/android/gms/internal/mlkit_common/zzol;

    const/4 v1, 0x0

    const/4 v2, 0x1

    if-eq v2, p2, :cond_0

    move p2, v1

    goto :goto_0

    :cond_0
    move p2, v2

    .line 1
    :goto_0
    invoke-static {p2}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object p2

    invoke-virtual {v0, p2}, Lcom/google/android/gms/internal/mlkit_common/zzol;->zzf(Ljava/lang/Boolean;)Lcom/google/android/gms/internal/mlkit_common/zzol;

    iget-object p2, p0, Lcom/google/android/gms/internal/mlkit_common/zzqc;->zzb:Lcom/google/android/gms/internal/mlkit_common/zzol;

    .line 2
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {p2, v0}, Lcom/google/android/gms/internal/mlkit_common/zzol;->zze(Ljava/lang/Boolean;)Lcom/google/android/gms/internal/mlkit_common/zzol;

    iget-object p2, p0, Lcom/google/android/gms/internal/mlkit_common/zzqc;->zza:Lcom/google/android/gms/internal/mlkit_common/zzlo;

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_common/zzqc;->zzb:Lcom/google/android/gms/internal/mlkit_common/zzol;

    .line 3
    invoke-virtual {v0}, Lcom/google/android/gms/internal/mlkit_common/zzol;->zzm()Lcom/google/android/gms/internal/mlkit_common/zzon;

    move-result-object v0

    invoke-virtual {p2, v0}, Lcom/google/android/gms/internal/mlkit_common/zzlo;->zzj(Lcom/google/android/gms/internal/mlkit_common/zzon;)Lcom/google/android/gms/internal/mlkit_common/zzlo;

    .line 4
    :try_start_0
    invoke-static {}, Lcom/google/android/gms/internal/mlkit_common/zzqn;->zza()Lcom/google/android/gms/internal/mlkit_common/zzqn;

    if-nez p1, :cond_1

    iget-object p1, p0, Lcom/google/android/gms/internal/mlkit_common/zzqc;->zza:Lcom/google/android/gms/internal/mlkit_common/zzlo;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/mlkit_common/zzlo;->zzk()Lcom/google/android/gms/internal/mlkit_common/zzlq;

    move-result-object p1

    .line 5
    new-instance p2, Lcom/google/firebase/encoders/json/JsonDataEncoderBuilder;

    invoke-direct {p2}, Lcom/google/firebase/encoders/json/JsonDataEncoderBuilder;-><init>()V

    sget-object v0, Lcom/google/android/gms/internal/mlkit_common/zzjn;->zza:Lcom/google/firebase/encoders/config/Configurator;

    invoke-virtual {p2, v0}, Lcom/google/firebase/encoders/json/JsonDataEncoderBuilder;->configureWith(Lcom/google/firebase/encoders/config/Configurator;)Lcom/google/firebase/encoders/json/JsonDataEncoderBuilder;

    move-result-object p2

    invoke-virtual {p2, v2}, Lcom/google/firebase/encoders/json/JsonDataEncoderBuilder;->ignoreNullValues(Z)Lcom/google/firebase/encoders/json/JsonDataEncoderBuilder;

    move-result-object p2

    invoke-virtual {p2}, Lcom/google/firebase/encoders/json/JsonDataEncoderBuilder;->build()Lcom/google/firebase/encoders/DataEncoder;

    move-result-object p2

    invoke-interface {p2, p1}, Lcom/google/firebase/encoders/DataEncoder;->encode(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p1

    const-string p2, "utf-8"

    .line 6
    invoke-virtual {p1, p2}, Ljava/lang/String;->getBytes(Ljava/lang/String;)[B

    move-result-object p1

    return-object p1

    :cond_1
    iget-object p1, p0, Lcom/google/android/gms/internal/mlkit_common/zzqc;->zza:Lcom/google/android/gms/internal/mlkit_common/zzlo;

    invoke-virtual {p1}, Lcom/google/android/gms/internal/mlkit_common/zzlo;->zzk()Lcom/google/android/gms/internal/mlkit_common/zzlq;

    move-result-object p1

    .line 7
    new-instance p2, Lcom/google/android/gms/internal/mlkit_common/zzbs;

    invoke-direct {p2}, Lcom/google/android/gms/internal/mlkit_common/zzbs;-><init>()V

    .line 8
    sget-object v0, Lcom/google/android/gms/internal/mlkit_common/zzjn;->zza:Lcom/google/firebase/encoders/config/Configurator;

    .line 9
    invoke-interface {v0, p2}, Lcom/google/firebase/encoders/config/Configurator;->configure(Lcom/google/firebase/encoders/config/EncoderConfig;)V

    .line 8
    invoke-virtual {p2}, Lcom/google/android/gms/internal/mlkit_common/zzbs;->zza()Lcom/google/android/gms/internal/mlkit_common/zzbt;

    move-result-object p2

    invoke-virtual {p2, p1}, Lcom/google/android/gms/internal/mlkit_common/zzbt;->zza(Ljava/lang/Object;)[B

    move-result-object p1
    :try_end_0
    .catch Ljava/io/UnsupportedEncodingException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    new-instance p2, Ljava/lang/UnsupportedOperationException;

    const-string v0, "Failed to covert logging to UTF-8 byte array"

    .line 10
    invoke-direct {p2, v0, p1}, Ljava/lang/UnsupportedOperationException;-><init>(Ljava/lang/String;Ljava/lang/Throwable;)V

    throw p2
.end method
