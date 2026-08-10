.class public final Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;
.super Lcom/google/android/gms/common/internal/safeparcel/AbstractSafeParcelable;
.source "com.google.android.gms:play-services-mlkit-barcode-scanning@@18.3.0"


# static fields
.field public static final CREATOR:Landroid/os/Parcelable$Creator;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Landroid/os/Parcelable$Creator<",
            "Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;",
            ">;"
        }
    .end annotation
.end field


# instance fields
.field private final zza:I

.field private final zzb:Ljava/lang/String;

.field private final zzc:Ljava/lang/String;

.field private final zzd:[B

.field private final zze:[Landroid/graphics/Point;

.field private final zzf:I

.field private final zzg:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvc;

.field private final zzh:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvf;

.field private final zzi:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvg;

.field private final zzj:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvi;

.field private final zzk:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvh;

.field private final zzl:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvd;

.field private final zzm:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuz;

.field private final zzn:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzva;

.field private final zzo:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvb;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvk;

    invoke-direct {v0}, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvk;-><init>()V

    sput-object v0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->CREATOR:Landroid/os/Parcelable$Creator;

    return-void
.end method

.method public constructor <init>(ILjava/lang/String;Ljava/lang/String;[B[Landroid/graphics/Point;ILcom/google/android/gms/internal/mlkit_vision_barcode/zzvc;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvf;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvg;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvi;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvh;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvd;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuz;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzva;Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvb;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/google/android/gms/common/internal/safeparcel/AbstractSafeParcelable;-><init>()V

    iput p1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zza:I

    iput-object p2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzb:Ljava/lang/String;

    iput-object p3, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzc:Ljava/lang/String;

    iput-object p4, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzd:[B

    iput-object p5, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zze:[Landroid/graphics/Point;

    iput p6, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzf:I

    iput-object p7, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzg:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvc;

    iput-object p8, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzh:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvf;

    iput-object p9, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzi:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvg;

    iput-object p10, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzj:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvi;

    iput-object p11, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzk:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvh;

    iput-object p12, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzl:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvd;

    iput-object p13, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzm:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuz;

    iput-object p14, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzn:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzva;

    iput-object p15, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzo:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvb;

    return-void
.end method


# virtual methods
.method public final writeToParcel(Landroid/os/Parcel;I)V
    .locals 4

    .line 1
    invoke-static {p1}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->beginObjectHeader(Landroid/os/Parcel;)I

    move-result v0

    const/4 v1, 0x1

    iget v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zza:I

    .line 2
    invoke-static {p1, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeInt(Landroid/os/Parcel;II)V

    iget-object v1, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzb:Ljava/lang/String;

    const/4 v2, 0x2

    const/4 v3, 0x0

    .line 3
    invoke-static {p1, v2, v1, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    const/4 v1, 0x3

    iget-object v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzc:Ljava/lang/String;

    .line 4
    invoke-static {p1, v1, v2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeString(Landroid/os/Parcel;ILjava/lang/String;Z)V

    const/4 v1, 0x4

    iget-object v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzd:[B

    .line 5
    invoke-static {p1, v1, v2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeByteArray(Landroid/os/Parcel;I[BZ)V

    const/4 v1, 0x5

    iget-object v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zze:[Landroid/graphics/Point;

    .line 6
    invoke-static {p1, v1, v2, p2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeTypedArray(Landroid/os/Parcel;I[Landroid/os/Parcelable;IZ)V

    const/4 v1, 0x6

    iget v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzf:I

    .line 7
    invoke-static {p1, v1, v2}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeInt(Landroid/os/Parcel;II)V

    const/4 v1, 0x7

    iget-object v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzg:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvc;

    .line 8
    invoke-static {p1, v1, v2, p2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    const/16 v1, 0x8

    iget-object v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzh:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvf;

    .line 9
    invoke-static {p1, v1, v2, p2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    const/16 v1, 0x9

    iget-object v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzi:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvg;

    .line 10
    invoke-static {p1, v1, v2, p2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    const/16 v1, 0xa

    iget-object v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzj:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvi;

    .line 11
    invoke-static {p1, v1, v2, p2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    const/16 v1, 0xb

    iget-object v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzk:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvh;

    .line 12
    invoke-static {p1, v1, v2, p2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    const/16 v1, 0xc

    iget-object v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzl:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvd;

    .line 13
    invoke-static {p1, v1, v2, p2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    const/16 v1, 0xd

    iget-object v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzm:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuz;

    .line 14
    invoke-static {p1, v1, v2, p2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    const/16 v1, 0xe

    iget-object v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzn:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzva;

    .line 15
    invoke-static {p1, v1, v2, p2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    const/16 v1, 0xf

    iget-object v2, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzo:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvb;

    .line 16
    invoke-static {p1, v1, v2, p2, v3}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->writeParcelable(Landroid/os/Parcel;ILandroid/os/Parcelable;IZ)V

    .line 17
    invoke-static {p1, v0}, Lcom/google/android/gms/common/internal/safeparcel/SafeParcelWriter;->finishObjectHeader(Landroid/os/Parcel;I)V

    return-void
.end method

.method public final zza()I
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zza:I

    return v0
.end method

.method public final zzb()I
    .locals 1

    iget v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzf:I

    return v0
.end method

.method public final zzc()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuz;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzm:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzuz;

    return-object v0
.end method

.method public final zzd()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzva;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzn:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzva;

    return-object v0
.end method

.method public final zze()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvb;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzo:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvb;

    return-object v0
.end method

.method public final zzf()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvc;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzg:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvc;

    return-object v0
.end method

.method public final zzg()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvd;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzl:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvd;

    return-object v0
.end method

.method public final zzh()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvf;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzh:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvf;

    return-object v0
.end method

.method public final zzi()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvg;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzi:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvg;

    return-object v0
.end method

.method public final zzj()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvh;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzk:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvh;

    return-object v0
.end method

.method public final zzk()Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvi;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzj:Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvi;

    return-object v0
.end method

.method public final zzl()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzb:Ljava/lang/String;

    return-object v0
.end method

.method public final zzm()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzc:Ljava/lang/String;

    return-object v0
.end method

.method public final zzn()[B
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zzd:[B

    return-object v0
.end method

.method public final zzo()[Landroid/graphics/Point;
    .locals 1

    iget-object v0, p0, Lcom/google/android/gms/internal/mlkit_vision_barcode/zzvj;->zze:[Landroid/graphics/Point;

    return-object v0
.end method
