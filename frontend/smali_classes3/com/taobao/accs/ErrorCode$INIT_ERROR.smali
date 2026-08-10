.class public final enum Lcom/taobao/accs/ErrorCode$INIT_ERROR;
.super Ljava/lang/Enum;
.source "Taobao"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/accs/ErrorCode;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "INIT_ERROR"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/taobao/accs/ErrorCode$INIT_ERROR;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/taobao/accs/ErrorCode$INIT_ERROR;

.field public static final enum APPKEY_NULL:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

.field public static final enum APPRECEIVER_NULL:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

.field public static final enum APPSECRET_NULL:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

.field public static final enum CONN_INVALID:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

.field public static final enum NO_CONNECTTION:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

.field public static final enum NO_NETWORK:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

.field public static final enum REQ_TIME_OUT:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

.field public static final enum SERVER_APPKEY_INVALID:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

.field public static final enum SERVER_DEVICEID_INVALID:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

.field public static final enum SERVER_PACKAGENAME_INVALID:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

.field public static final enum SERVER_TAIR_ERROR:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

.field public static final enum SUCCESS:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

.field public static final enum UNKNOWN_ERROR:Lcom/taobao/accs/ErrorCode$INIT_ERROR;


# direct methods
.method static constructor <clinit>()V
    .locals 15

    .line 65
    new-instance v0, Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    const-string v1, "NO_NETWORK"

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lcom/taobao/accs/ErrorCode$INIT_ERROR;-><init>(Ljava/lang/String;I)V

    sput-object v0, Lcom/taobao/accs/ErrorCode$INIT_ERROR;->NO_NETWORK:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    .line 66
    new-instance v1, Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    const-string v2, "APPKEY_NULL"

    const/4 v3, 0x1

    invoke-direct {v1, v2, v3}, Lcom/taobao/accs/ErrorCode$INIT_ERROR;-><init>(Ljava/lang/String;I)V

    sput-object v1, Lcom/taobao/accs/ErrorCode$INIT_ERROR;->APPKEY_NULL:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    .line 67
    new-instance v2, Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    const-string v3, "APPSECRET_NULL"

    const/4 v4, 0x2

    invoke-direct {v2, v3, v4}, Lcom/taobao/accs/ErrorCode$INIT_ERROR;-><init>(Ljava/lang/String;I)V

    sput-object v2, Lcom/taobao/accs/ErrorCode$INIT_ERROR;->APPSECRET_NULL:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    .line 68
    new-instance v3, Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    const-string v4, "APPRECEIVER_NULL"

    const/4 v5, 0x3

    invoke-direct {v3, v4, v5}, Lcom/taobao/accs/ErrorCode$INIT_ERROR;-><init>(Ljava/lang/String;I)V

    sput-object v3, Lcom/taobao/accs/ErrorCode$INIT_ERROR;->APPRECEIVER_NULL:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    .line 69
    new-instance v4, Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    const-string v5, "REQ_TIME_OUT"

    const/4 v6, 0x4

    invoke-direct {v4, v5, v6}, Lcom/taobao/accs/ErrorCode$INIT_ERROR;-><init>(Ljava/lang/String;I)V

    sput-object v4, Lcom/taobao/accs/ErrorCode$INIT_ERROR;->REQ_TIME_OUT:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    .line 70
    new-instance v5, Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    const-string v6, "CONN_INVALID"

    const/4 v7, 0x5

    invoke-direct {v5, v6, v7}, Lcom/taobao/accs/ErrorCode$INIT_ERROR;-><init>(Ljava/lang/String;I)V

    sput-object v5, Lcom/taobao/accs/ErrorCode$INIT_ERROR;->CONN_INVALID:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    .line 71
    new-instance v6, Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    const-string v7, "NO_CONNECTTION"

    const/4 v8, 0x6

    invoke-direct {v6, v7, v8}, Lcom/taobao/accs/ErrorCode$INIT_ERROR;-><init>(Ljava/lang/String;I)V

    sput-object v6, Lcom/taobao/accs/ErrorCode$INIT_ERROR;->NO_CONNECTTION:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    .line 72
    new-instance v7, Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    const-string v8, "UNKNOWN_ERROR"

    const/4 v9, 0x7

    invoke-direct {v7, v8, v9}, Lcom/taobao/accs/ErrorCode$INIT_ERROR;-><init>(Ljava/lang/String;I)V

    sput-object v7, Lcom/taobao/accs/ErrorCode$INIT_ERROR;->UNKNOWN_ERROR:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    .line 73
    new-instance v8, Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    const-string v9, "SERVER_TAIR_ERROR"

    const/16 v10, 0x8

    invoke-direct {v8, v9, v10}, Lcom/taobao/accs/ErrorCode$INIT_ERROR;-><init>(Ljava/lang/String;I)V

    sput-object v8, Lcom/taobao/accs/ErrorCode$INIT_ERROR;->SERVER_TAIR_ERROR:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    .line 74
    new-instance v9, Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    const-string v10, "SERVER_DEVICEID_INVALID"

    const/16 v11, 0x9

    invoke-direct {v9, v10, v11}, Lcom/taobao/accs/ErrorCode$INIT_ERROR;-><init>(Ljava/lang/String;I)V

    sput-object v9, Lcom/taobao/accs/ErrorCode$INIT_ERROR;->SERVER_DEVICEID_INVALID:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    .line 75
    new-instance v10, Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    const-string v11, "SERVER_APPKEY_INVALID"

    const/16 v12, 0xa

    invoke-direct {v10, v11, v12}, Lcom/taobao/accs/ErrorCode$INIT_ERROR;-><init>(Ljava/lang/String;I)V

    sput-object v10, Lcom/taobao/accs/ErrorCode$INIT_ERROR;->SERVER_APPKEY_INVALID:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    .line 76
    new-instance v11, Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    const-string v12, "SERVER_PACKAGENAME_INVALID"

    const/16 v13, 0xb

    invoke-direct {v11, v12, v13}, Lcom/taobao/accs/ErrorCode$INIT_ERROR;-><init>(Ljava/lang/String;I)V

    sput-object v11, Lcom/taobao/accs/ErrorCode$INIT_ERROR;->SERVER_PACKAGENAME_INVALID:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    .line 77
    new-instance v12, Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    const-string v13, "SUCCESS"

    const/16 v14, 0xc

    invoke-direct {v12, v13, v14}, Lcom/taobao/accs/ErrorCode$INIT_ERROR;-><init>(Ljava/lang/String;I)V

    sput-object v12, Lcom/taobao/accs/ErrorCode$INIT_ERROR;->SUCCESS:Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    filled-new-array/range {v0 .. v12}, [Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    move-result-object v0

    sput-object v0, Lcom/taobao/accs/ErrorCode$INIT_ERROR;->$VALUES:[Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 64
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/taobao/accs/ErrorCode$INIT_ERROR;
    .locals 1

    const-class v0, Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    .line 64
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    return-object p0
.end method

.method public static values()[Lcom/taobao/accs/ErrorCode$INIT_ERROR;
    .locals 1

    sget-object v0, Lcom/taobao/accs/ErrorCode$INIT_ERROR;->$VALUES:[Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    .line 64
    invoke-virtual {v0}, [Lcom/taobao/accs/ErrorCode$INIT_ERROR;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/taobao/accs/ErrorCode$INIT_ERROR;

    return-object v0
.end method


# virtual methods
.method public getErrorCode()I
    .locals 1

    .line 82
    invoke-virtual {p0}, Lcom/taobao/accs/ErrorCode$INIT_ERROR;->ordinal()I

    move-result v0

    add-int/lit16 v0, v0, 0x3e8

    return v0
.end method
