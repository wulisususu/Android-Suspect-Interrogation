.class public final Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;
.super Ljava/lang/Object;
.source "OSBARCScanParameters.kt"

# interfaces
.implements Ljava/io/Serializable;


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000(\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0008\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u001a\n\u0002\u0010\u0000\n\u0002\u0008\u0003\u0008\u0087\u0008\u0018\u00002\u00020\u0001BG\u0012\u0008\u0010\u0002\u001a\u0004\u0018\u00010\u0003\u0012\u0008\u0010\u0004\u001a\u0004\u0018\u00010\u0005\u0012\u0008\u0010\u0006\u001a\u0004\u0018\u00010\u0005\u0012\u0006\u0010\u0007\u001a\u00020\u0008\u0012\u0006\u0010\t\u001a\u00020\u0003\u0012\u0008\u0010\n\u001a\u0004\u0018\u00010\u0005\u0012\u0008\u0010\u000b\u001a\u0004\u0018\u00010\u0003\u00a2\u0006\u0002\u0010\u000cJ\u000b\u0010\u0018\u001a\u0004\u0018\u00010\u0003H\u00c6\u0003J\u0010\u0010\u0019\u001a\u0004\u0018\u00010\u0005H\u00c6\u0003\u00a2\u0006\u0002\u0010\u0010J\u0010\u0010\u001a\u001a\u0004\u0018\u00010\u0005H\u00c6\u0003\u00a2\u0006\u0002\u0010\u0010J\t\u0010\u001b\u001a\u00020\u0008H\u00c6\u0003J\t\u0010\u001c\u001a\u00020\u0003H\u00c6\u0003J\u0010\u0010\u001d\u001a\u0004\u0018\u00010\u0005H\u00c6\u0003\u00a2\u0006\u0002\u0010\u0010J\u000b\u0010\u001e\u001a\u0004\u0018\u00010\u0003H\u00c6\u0003J^\u0010\u001f\u001a\u00020\u00002\n\u0008\u0002\u0010\u0002\u001a\u0004\u0018\u00010\u00032\n\u0008\u0002\u0010\u0004\u001a\u0004\u0018\u00010\u00052\n\u0008\u0002\u0010\u0006\u001a\u0004\u0018\u00010\u00052\u0008\u0008\u0002\u0010\u0007\u001a\u00020\u00082\u0008\u0008\u0002\u0010\t\u001a\u00020\u00032\n\u0008\u0002\u0010\n\u001a\u0004\u0018\u00010\u00052\n\u0008\u0002\u0010\u000b\u001a\u0004\u0018\u00010\u0003H\u00c6\u0001\u00a2\u0006\u0002\u0010 J\u0013\u0010!\u001a\u00020\u00082\u0008\u0010\"\u001a\u0004\u0018\u00010#H\u00d6\u0003J\t\u0010$\u001a\u00020\u0005H\u00d6\u0001J\t\u0010%\u001a\u00020\u0003H\u00d6\u0001R\u0018\u0010\u000b\u001a\u0004\u0018\u00010\u00038\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\r\u0010\u000eR\u001a\u0010\u0004\u001a\u0004\u0018\u00010\u00058\u0006X\u0087\u0004\u00a2\u0006\n\n\u0002\u0010\u0011\u001a\u0004\u0008\u000f\u0010\u0010R\u001a\u0010\n\u001a\u0004\u0018\u00010\u00058\u0006X\u0087\u0004\u00a2\u0006\n\n\u0002\u0010\u0011\u001a\u0004\u0008\u0012\u0010\u0010R\u0016\u0010\u0007\u001a\u00020\u00088\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0013\u0010\u0014R\u0018\u0010\u0002\u001a\u0004\u0018\u00010\u00038\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0015\u0010\u000eR\u001a\u0010\u0006\u001a\u0004\u0018\u00010\u00058\u0006X\u0087\u0004\u00a2\u0006\n\n\u0002\u0010\u0011\u001a\u0004\u0008\u0016\u0010\u0010R\u0016\u0010\t\u001a\u00020\u00038\u0006X\u0087\u0004\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0017\u0010\u000e\u00a8\u0006&"
    }
    d2 = {
        "Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;",
        "Ljava/io/Serializable;",
        "scanInstructions",
        "",
        "cameraDirection",
        "",
        "scanOrientation",
        "scanButton",
        "",
        "scanText",
        "hint",
        "androidScanningLibrary",
        "(Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/Integer;ZLjava/lang/String;Ljava/lang/Integer;Ljava/lang/String;)V",
        "getAndroidScanningLibrary",
        "()Ljava/lang/String;",
        "getCameraDirection",
        "()Ljava/lang/Integer;",
        "Ljava/lang/Integer;",
        "getHint",
        "getScanButton",
        "()Z",
        "getScanInstructions",
        "getScanOrientation",
        "getScanText",
        "component1",
        "component2",
        "component3",
        "component4",
        "component5",
        "component6",
        "component7",
        "copy",
        "(Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/Integer;ZLjava/lang/String;Ljava/lang/Integer;Ljava/lang/String;)Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;",
        "equals",
        "other",
        "",
        "hashCode",
        "toString",
        "OSBarcodeLib_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x9,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final $stable:I


# instance fields
.field private final androidScanningLibrary:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "androidScanningLibrary"
    .end annotation
.end field

.field private final cameraDirection:Ljava/lang/Integer;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "cameraDirection"
    .end annotation
.end field

.field private final hint:Ljava/lang/Integer;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "hint"
    .end annotation
.end field

.field private final scanButton:Z
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "scanButton"
    .end annotation
.end field

.field private final scanInstructions:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "scanInstructions"
    .end annotation
.end field

.field private final scanOrientation:Ljava/lang/Integer;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "scanOrientation"
    .end annotation
.end field

.field private final scanText:Ljava/lang/String;
    .annotation runtime Lcom/google/gson/annotations/SerializedName;
        value = "scanText"
    .end annotation
.end field


# direct methods
.method static constructor <clinit>()V
    .locals 0

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/Integer;ZLjava/lang/String;Ljava/lang/Integer;Ljava/lang/String;)V
    .locals 1

    const-string v0, "scanText"

    invoke-static {p5, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 9
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanInstructions:Ljava/lang/String;

    iput-object p2, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->cameraDirection:Ljava/lang/Integer;

    iput-object p3, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanOrientation:Ljava/lang/Integer;

    iput-boolean p4, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanButton:Z

    iput-object p5, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanText:Ljava/lang/String;

    iput-object p6, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->hint:Ljava/lang/Integer;

    iput-object p7, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->androidScanningLibrary:Ljava/lang/String;

    return-void
.end method

.method public static synthetic copy$default(Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/Integer;ZLjava/lang/String;Ljava/lang/Integer;Ljava/lang/String;ILjava/lang/Object;)Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;
    .locals 5

    and-int/lit8 p9, p8, 0x1

    if-eqz p9, :cond_0

    iget-object p1, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanInstructions:Ljava/lang/String;

    :cond_0
    and-int/lit8 p9, p8, 0x2

    if-eqz p9, :cond_1

    iget-object p2, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->cameraDirection:Ljava/lang/Integer;

    :cond_1
    move-object p9, p2

    and-int/lit8 p2, p8, 0x4

    if-eqz p2, :cond_2

    iget-object p3, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanOrientation:Ljava/lang/Integer;

    :cond_2
    move-object v0, p3

    and-int/lit8 p2, p8, 0x8

    if-eqz p2, :cond_3

    iget-boolean p4, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanButton:Z

    :cond_3
    move v1, p4

    and-int/lit8 p2, p8, 0x10

    if-eqz p2, :cond_4

    iget-object p5, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanText:Ljava/lang/String;

    :cond_4
    move-object v2, p5

    and-int/lit8 p2, p8, 0x20

    if-eqz p2, :cond_5

    iget-object p6, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->hint:Ljava/lang/Integer;

    :cond_5
    move-object v3, p6

    and-int/lit8 p2, p8, 0x40

    if-eqz p2, :cond_6

    iget-object p7, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->androidScanningLibrary:Ljava/lang/String;

    :cond_6
    move-object v4, p7

    move-object p2, p0

    move-object p3, p1

    move-object p4, p9

    move-object p5, v0

    move p6, v1

    move-object p7, v2

    move-object p8, v3

    move-object p9, v4

    invoke-virtual/range {p2 .. p9}, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->copy(Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/Integer;ZLjava/lang/String;Ljava/lang/Integer;Ljava/lang/String;)Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final component1()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanInstructions:Ljava/lang/String;

    return-object v0
.end method

.method public final component2()Ljava/lang/Integer;
    .locals 1

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->cameraDirection:Ljava/lang/Integer;

    return-object v0
.end method

.method public final component3()Ljava/lang/Integer;
    .locals 1

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanOrientation:Ljava/lang/Integer;

    return-object v0
.end method

.method public final component4()Z
    .locals 1

    iget-boolean v0, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanButton:Z

    return v0
.end method

.method public final component5()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanText:Ljava/lang/String;

    return-object v0
.end method

.method public final component6()Ljava/lang/Integer;
    .locals 1

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->hint:Ljava/lang/Integer;

    return-object v0
.end method

.method public final component7()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->androidScanningLibrary:Ljava/lang/String;

    return-object v0
.end method

.method public final copy(Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/Integer;ZLjava/lang/String;Ljava/lang/Integer;Ljava/lang/String;)Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;
    .locals 9

    const-string v0, "scanText"

    move-object v6, p5

    invoke-static {p5, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    new-instance v0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;

    move-object v1, v0

    move-object v2, p1

    move-object v3, p2

    move-object v4, p3

    move v5, p4

    move-object v7, p6

    move-object/from16 v8, p7

    invoke-direct/range {v1 .. v8}, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;-><init>(Ljava/lang/String;Ljava/lang/Integer;Ljava/lang/Integer;ZLjava/lang/String;Ljava/lang/Integer;Ljava/lang/String;)V

    return-object v0
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 4

    const/4 v0, 0x1

    if-ne p0, p1, :cond_0

    return v0

    :cond_0
    instance-of v1, p1, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;

    const/4 v2, 0x0

    if-nez v1, :cond_1

    return v2

    :cond_1
    check-cast p1, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;

    iget-object v1, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanInstructions:Ljava/lang/String;

    iget-object v3, p1, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanInstructions:Ljava/lang/String;

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_2

    return v2

    :cond_2
    iget-object v1, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->cameraDirection:Ljava/lang/Integer;

    iget-object v3, p1, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->cameraDirection:Ljava/lang/Integer;

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_3

    return v2

    :cond_3
    iget-object v1, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanOrientation:Ljava/lang/Integer;

    iget-object v3, p1, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanOrientation:Ljava/lang/Integer;

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_4

    return v2

    :cond_4
    iget-boolean v1, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanButton:Z

    iget-boolean v3, p1, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanButton:Z

    if-eq v1, v3, :cond_5

    return v2

    :cond_5
    iget-object v1, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanText:Ljava/lang/String;

    iget-object v3, p1, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanText:Ljava/lang/String;

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_6

    return v2

    :cond_6
    iget-object v1, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->hint:Ljava/lang/Integer;

    iget-object v3, p1, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->hint:Ljava/lang/Integer;

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_7

    return v2

    :cond_7
    iget-object v1, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->androidScanningLibrary:Ljava/lang/String;

    iget-object p1, p1, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->androidScanningLibrary:Ljava/lang/String;

    invoke-static {v1, p1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result p1

    if-nez p1, :cond_8

    return v2

    :cond_8
    return v0
.end method

.method public final getAndroidScanningLibrary()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->androidScanningLibrary:Ljava/lang/String;

    return-object v0
.end method

.method public final getCameraDirection()Ljava/lang/Integer;
    .locals 1

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->cameraDirection:Ljava/lang/Integer;

    return-object v0
.end method

.method public final getHint()Ljava/lang/Integer;
    .locals 1

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->hint:Ljava/lang/Integer;

    return-object v0
.end method

.method public final getScanButton()Z
    .locals 1

    iget-boolean v0, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanButton:Z

    return v0
.end method

.method public final getScanInstructions()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanInstructions:Ljava/lang/String;

    return-object v0
.end method

.method public final getScanOrientation()Ljava/lang/Integer;
    .locals 1

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanOrientation:Ljava/lang/Integer;

    return-object v0
.end method

.method public final getScanText()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanText:Ljava/lang/String;

    return-object v0
.end method

.method public hashCode()I
    .locals 3

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanInstructions:Ljava/lang/String;

    const/4 v1, 0x0

    if-nez v0, :cond_0

    move v0, v1

    goto :goto_0

    :cond_0
    invoke-virtual {v0}, Ljava/lang/String;->hashCode()I

    move-result v0

    :goto_0
    mul-int/lit8 v0, v0, 0x1f

    iget-object v2, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->cameraDirection:Ljava/lang/Integer;

    if-nez v2, :cond_1

    move v2, v1

    goto :goto_1

    :cond_1
    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v2

    :goto_1
    add-int/2addr v0, v2

    mul-int/lit8 v0, v0, 0x1f

    iget-object v2, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanOrientation:Ljava/lang/Integer;

    if-nez v2, :cond_2

    move v2, v1

    goto :goto_2

    :cond_2
    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v2

    :goto_2
    add-int/2addr v0, v2

    mul-int/lit8 v0, v0, 0x1f

    iget-boolean v2, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanButton:Z

    invoke-static {v2}, Ljava/lang/Boolean;->hashCode(Z)I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v0, v0, 0x1f

    iget-object v2, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanText:Ljava/lang/String;

    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v2

    add-int/2addr v0, v2

    mul-int/lit8 v0, v0, 0x1f

    iget-object v2, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->hint:Ljava/lang/Integer;

    if-nez v2, :cond_3

    move v2, v1

    goto :goto_3

    :cond_3
    invoke-virtual {v2}, Ljava/lang/Object;->hashCode()I

    move-result v2

    :goto_3
    add-int/2addr v0, v2

    mul-int/lit8 v0, v0, 0x1f

    iget-object v2, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->androidScanningLibrary:Ljava/lang/String;

    if-nez v2, :cond_4

    goto :goto_4

    :cond_4
    invoke-virtual {v2}, Ljava/lang/String;->hashCode()I

    move-result v1

    :goto_4
    add-int/2addr v0, v1

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 2

    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "OSBARCScanParameters(scanInstructions="

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanInstructions:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", cameraDirection="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->cameraDirection:Ljava/lang/Integer;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", scanOrientation="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanOrientation:Ljava/lang/Integer;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", scanButton="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-boolean v1, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanButton:Z

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", scanText="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->scanText:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", hint="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->hint:Ljava/lang/Integer;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, ", androidScanningLibrary="

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/outsystems/plugins/barcode/model/OSBARCScanParameters;->androidScanningLibrary:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v1, 0x29

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
