.class public final enum Lcom/alibaba/sdk/android/oss/common/HttpProtocol;
.super Ljava/lang/Enum;
.source "HttpProtocol.java"


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/alibaba/sdk/android/oss/common/HttpProtocol;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/alibaba/sdk/android/oss/common/HttpProtocol;

.field public static final enum HTTP:Lcom/alibaba/sdk/android/oss/common/HttpProtocol;

.field public static final enum HTTPS:Lcom/alibaba/sdk/android/oss/common/HttpProtocol;


# instance fields
.field private final httpProtocol:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 5

    .line 4
    new-instance v0, Lcom/alibaba/sdk/android/oss/common/HttpProtocol;

    const/4 v1, 0x0

    const-string v2, "http"

    const-string v3, "HTTP"

    invoke-direct {v0, v3, v1, v2}, Lcom/alibaba/sdk/android/oss/common/HttpProtocol;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v0, Lcom/alibaba/sdk/android/oss/common/HttpProtocol;->HTTP:Lcom/alibaba/sdk/android/oss/common/HttpProtocol;

    .line 5
    new-instance v1, Lcom/alibaba/sdk/android/oss/common/HttpProtocol;

    const/4 v2, 0x1

    const-string v3, "https"

    const-string v4, "HTTPS"

    invoke-direct {v1, v4, v2, v3}, Lcom/alibaba/sdk/android/oss/common/HttpProtocol;-><init>(Ljava/lang/String;ILjava/lang/String;)V

    sput-object v1, Lcom/alibaba/sdk/android/oss/common/HttpProtocol;->HTTPS:Lcom/alibaba/sdk/android/oss/common/HttpProtocol;

    filled-new-array {v0, v1}, [Lcom/alibaba/sdk/android/oss/common/HttpProtocol;

    move-result-object v0

    sput-object v0, Lcom/alibaba/sdk/android/oss/common/HttpProtocol;->$VALUES:[Lcom/alibaba/sdk/android/oss/common/HttpProtocol;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;ILjava/lang/String;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    .line 8
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    iput-object p3, p0, Lcom/alibaba/sdk/android/oss/common/HttpProtocol;->httpProtocol:Ljava/lang/String;

    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/alibaba/sdk/android/oss/common/HttpProtocol;
    .locals 1

    const-class v0, Lcom/alibaba/sdk/android/oss/common/HttpProtocol;

    .line 3
    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object p0

    check-cast p0, Lcom/alibaba/sdk/android/oss/common/HttpProtocol;

    return-object p0
.end method

.method public static values()[Lcom/alibaba/sdk/android/oss/common/HttpProtocol;
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/oss/common/HttpProtocol;->$VALUES:[Lcom/alibaba/sdk/android/oss/common/HttpProtocol;

    .line 3
    invoke-virtual {v0}, [Lcom/alibaba/sdk/android/oss/common/HttpProtocol;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/alibaba/sdk/android/oss/common/HttpProtocol;

    return-object v0
.end method


# virtual methods
.method public toString()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/common/HttpProtocol;->httpProtocol:Ljava/lang/String;

    return-object v0
.end method
