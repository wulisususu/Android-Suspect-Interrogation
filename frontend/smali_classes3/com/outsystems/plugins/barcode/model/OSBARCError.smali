.class public final enum Lcom/outsystems/plugins/barcode/model/OSBARCError;
.super Ljava/lang/Enum;
.source "OSBARCError.kt"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/outsystems/plugins/barcode/model/OSBARCError;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0018\n\u0002\u0018\u0002\n\u0002\u0010\u0010\n\u0000\n\u0002\u0010\u0008\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u000c\u0008\u0086\u0081\u0002\u0018\u00002\u0008\u0012\u0004\u0012\u00020\u00000\u0001B\u0017\u0008\u0002\u0012\u0006\u0010\u0002\u001a\u00020\u0003\u0012\u0006\u0010\u0004\u001a\u00020\u0005\u00a2\u0006\u0002\u0010\u0006R\u0011\u0010\u0002\u001a\u00020\u0003\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u0007\u0010\u0008R\u0011\u0010\u0004\u001a\u00020\u0005\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\t\u0010\nj\u0002\u0008\u000bj\u0002\u0008\u000cj\u0002\u0008\rj\u0002\u0008\u000ej\u0002\u0008\u000fj\u0002\u0008\u0010\u00a8\u0006\u0011"
    }
    d2 = {
        "Lcom/outsystems/plugins/barcode/model/OSBARCError;",
        "",
        "code",
        "",
        "description",
        "",
        "(Ljava/lang/String;IILjava/lang/String;)V",
        "getCode",
        "()I",
        "getDescription",
        "()Ljava/lang/String;",
        "SCANNING_GENERAL_ERROR",
        "SCAN_CANCELLED_ERROR",
        "CAMERA_PERMISSION_DENIED_ERROR",
        "INVALID_PARAMETERS_ERROR",
        "ZXING_LIBRARY_ERROR",
        "MLKIT_LIBRARY_ERROR",
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
.field private static final synthetic $ENTRIES:Lkotlin/enums/EnumEntries;

.field private static final synthetic $VALUES:[Lcom/outsystems/plugins/barcode/model/OSBARCError;

.field public static final enum CAMERA_PERMISSION_DENIED_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

.field public static final enum INVALID_PARAMETERS_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

.field public static final enum MLKIT_LIBRARY_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

.field public static final enum SCANNING_GENERAL_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

.field public static final enum SCAN_CANCELLED_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

.field public static final enum ZXING_LIBRARY_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;


# instance fields
.field private final code:I

.field private final description:Ljava/lang/String;


# direct methods
.method private static final synthetic $values()[Lcom/outsystems/plugins/barcode/model/OSBARCError;
    .locals 6

    sget-object v0, Lcom/outsystems/plugins/barcode/model/OSBARCError;->SCANNING_GENERAL_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    sget-object v1, Lcom/outsystems/plugins/barcode/model/OSBARCError;->SCAN_CANCELLED_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    sget-object v2, Lcom/outsystems/plugins/barcode/model/OSBARCError;->CAMERA_PERMISSION_DENIED_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    sget-object v3, Lcom/outsystems/plugins/barcode/model/OSBARCError;->INVALID_PARAMETERS_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    sget-object v4, Lcom/outsystems/plugins/barcode/model/OSBARCError;->ZXING_LIBRARY_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    sget-object v5, Lcom/outsystems/plugins/barcode/model/OSBARCError;->MLKIT_LIBRARY_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    filled-new-array/range {v0 .. v5}, [Lcom/outsystems/plugins/barcode/model/OSBARCError;

    move-result-object v0

    return-object v0
.end method

.method static constructor <clinit>()V
    .locals 6

    .line 7
    new-instance v0, Lcom/outsystems/plugins/barcode/model/OSBARCError;

    const-string v1, "Error while trying to scan code."

    const-string v2, "SCANNING_GENERAL_ERROR"

    const/4 v3, 0x0

    const/4 v4, 0x4

    invoke-direct {v0, v2, v3, v4, v1}, Lcom/outsystems/plugins/barcode/model/OSBARCError;-><init>(Ljava/lang/String;IILjava/lang/String;)V

    sput-object v0, Lcom/outsystems/plugins/barcode/model/OSBARCError;->SCANNING_GENERAL_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    .line 8
    new-instance v0, Lcom/outsystems/plugins/barcode/model/OSBARCError;

    const/4 v1, 0x6

    const-string v2, "Couldn\'t scan because the process was cancelled."

    const-string v3, "SCAN_CANCELLED_ERROR"

    const/4 v5, 0x1

    invoke-direct {v0, v3, v5, v1, v2}, Lcom/outsystems/plugins/barcode/model/OSBARCError;-><init>(Ljava/lang/String;IILjava/lang/String;)V

    sput-object v0, Lcom/outsystems/plugins/barcode/model/OSBARCError;->SCAN_CANCELLED_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    .line 9
    new-instance v0, Lcom/outsystems/plugins/barcode/model/OSBARCError;

    const/4 v1, 0x7

    const-string v2, "Couldn\'t scan because camera access wasn\'t provided. Check your camera permissions and try again."

    const-string v3, "CAMERA_PERMISSION_DENIED_ERROR"

    const/4 v5, 0x2

    invoke-direct {v0, v3, v5, v1, v2}, Lcom/outsystems/plugins/barcode/model/OSBARCError;-><init>(Ljava/lang/String;IILjava/lang/String;)V

    sput-object v0, Lcom/outsystems/plugins/barcode/model/OSBARCError;->CAMERA_PERMISSION_DENIED_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    .line 10
    new-instance v0, Lcom/outsystems/plugins/barcode/model/OSBARCError;

    const/16 v1, 0x8

    const-string v2, "Scanning parameters are invalid."

    const-string v3, "INVALID_PARAMETERS_ERROR"

    const/4 v5, 0x3

    invoke-direct {v0, v3, v5, v1, v2}, Lcom/outsystems/plugins/barcode/model/OSBARCError;-><init>(Ljava/lang/String;IILjava/lang/String;)V

    sput-object v0, Lcom/outsystems/plugins/barcode/model/OSBARCError;->INVALID_PARAMETERS_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    .line 11
    new-instance v0, Lcom/outsystems/plugins/barcode/model/OSBARCError;

    const/16 v1, 0x9

    const-string v2, "There was an error scanning the barcode with ZXing."

    const-string v3, "ZXING_LIBRARY_ERROR"

    invoke-direct {v0, v3, v4, v1, v2}, Lcom/outsystems/plugins/barcode/model/OSBARCError;-><init>(Ljava/lang/String;IILjava/lang/String;)V

    sput-object v0, Lcom/outsystems/plugins/barcode/model/OSBARCError;->ZXING_LIBRARY_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    .line 12
    new-instance v0, Lcom/outsystems/plugins/barcode/model/OSBARCError;

    const/16 v1, 0xa

    const-string v2, "There was an error scanning the barcode with ML Kit."

    const-string v3, "MLKIT_LIBRARY_ERROR"

    const/4 v4, 0x5

    invoke-direct {v0, v3, v4, v1, v2}, Lcom/outsystems/plugins/barcode/model/OSBARCError;-><init>(Ljava/lang/String;IILjava/lang/String;)V

    sput-object v0, Lcom/outsystems/plugins/barcode/model/OSBARCError;->MLKIT_LIBRARY_ERROR:Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-static {}, Lcom/outsystems/plugins/barcode/model/OSBARCError;->$values()[Lcom/outsystems/plugins/barcode/model/OSBARCError;

    move-result-object v0

    sput-object v0, Lcom/outsystems/plugins/barcode/model/OSBARCError;->$VALUES:[Lcom/outsystems/plugins/barcode/model/OSBARCError;

    check-cast v0, [Ljava/lang/Enum;

    invoke-static {v0}, Lkotlin/enums/EnumEntriesKt;->enumEntries([Ljava/lang/Enum;)Lkotlin/enums/EnumEntries;

    move-result-object v0

    sput-object v0, Lcom/outsystems/plugins/barcode/model/OSBARCError;->$ENTRIES:Lkotlin/enums/EnumEntries;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;IILjava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(I",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 6
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput p3, p0, Lcom/outsystems/plugins/barcode/model/OSBARCError;->code:I

    iput-object p4, p0, Lcom/outsystems/plugins/barcode/model/OSBARCError;->description:Ljava/lang/String;

    return-void
.end method

.method public static getEntries()Lkotlin/enums/EnumEntries;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Lkotlin/enums/EnumEntries<",
            "Lcom/outsystems/plugins/barcode/model/OSBARCError;",
            ">;"
        }
    .end annotation

    sget-object v0, Lcom/outsystems/plugins/barcode/model/OSBARCError;->$ENTRIES:Lkotlin/enums/EnumEntries;

    return-object v0
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/outsystems/plugins/barcode/model/OSBARCError;
    .locals 1

    const-class v0, Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/outsystems/plugins/barcode/model/OSBARCError;

    return-object p0
.end method

.method public static values()[Lcom/outsystems/plugins/barcode/model/OSBARCError;
    .locals 1

    sget-object v0, Lcom/outsystems/plugins/barcode/model/OSBARCError;->$VALUES:[Lcom/outsystems/plugins/barcode/model/OSBARCError;

    invoke-virtual {v0}, [Ljava/lang/Object;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/outsystems/plugins/barcode/model/OSBARCError;

    return-object v0
.end method


# virtual methods
.method public final getCode()I
    .locals 1

    iget v0, p0, Lcom/outsystems/plugins/barcode/model/OSBARCError;->code:I

    return v0
.end method

.method public final getDescription()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/outsystems/plugins/barcode/model/OSBARCError;->description:Ljava/lang/String;

    return-object v0
.end method
