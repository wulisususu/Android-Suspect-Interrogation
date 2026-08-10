.class public Lcom/alibaba/sdk/android/tbrest/SendService;
.super Ljava/lang/Object;
.source "SendService.java"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;
    }
.end annotation


# static fields
.field static final instance:Lcom/alibaba/sdk/android/tbrest/SendService;


# instance fields
.field public appId:Ljava/lang/String;

.field public appKey:Ljava/lang/String;

.field public appSecret:Ljava/lang/String;

.field public appVersion:Ljava/lang/String;

.field public channel:Ljava/lang/String;

.field public context:Landroid/content/Context;

.field public country:Ljava/lang/String;

.field public host:Ljava/lang/String;

.field private noCollectionDataType:I

.field public openHttp:Ljava/lang/Boolean;

.field private sendAsyncExecutor:Lcom/alibaba/sdk/android/tbrest/a;

.field public userNick:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 73
    new-instance v0, Lcom/alibaba/sdk/android/tbrest/SendService;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/tbrest/SendService;-><init>()V

    sput-object v0, Lcom/alibaba/sdk/android/tbrest/SendService;->instance:Lcom/alibaba/sdk/android/tbrest/SendService;

    return-void
.end method

.method public constructor <init>()V
    .locals 3

    .line 16
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->context:Landroid/content/Context;

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->appId:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->appKey:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->appSecret:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->appVersion:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->channel:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->userNick:Ljava/lang/String;

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->host:Ljava/lang/String;

    const/4 v1, 0x0

    .line 61
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v2

    iput-object v2, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->openHttp:Ljava/lang/Boolean;

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->country:Ljava/lang/String;

    iput v1, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->noCollectionDataType:I

    .line 74
    new-instance v0, Lcom/alibaba/sdk/android/tbrest/a;

    invoke-direct {v0}, Lcom/alibaba/sdk/android/tbrest/a;-><init>()V

    iput-object v0, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->sendAsyncExecutor:Lcom/alibaba/sdk/android/tbrest/a;

    return-void
.end method

.method private canSend()Ljava/lang/Boolean;
    .locals 2

    iget-object v0, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->appId:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->appVersion:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->appKey:Ljava/lang/String;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->context:Landroid/content/Context;

    if-nez v0, :cond_0

    goto :goto_0

    :cond_0
    const/4 v0, 0x1

    .line 245
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0

    .line 240
    :cond_1
    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    const-string v1, "have send args is null\uff0cyou must init first. appId "

    invoke-direct {v0, v1}, Ljava/lang/StringBuilder;-><init>(Ljava/lang/String;)V

    iget-object v1, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->appId:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " appVersion "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->appVersion:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v1, " appKey "

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->appKey:Ljava/lang/String;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Lcom/alibaba/sdk/android/tbrest/utils/LogUtil;->e(Ljava/lang/String;)V

    const/4 v0, 0x0

    .line 243
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0
.end method

.method public static getInstance()Lcom/alibaba/sdk/android/tbrest/SendService;
    .locals 1

    sget-object v0, Lcom/alibaba/sdk/android/tbrest/SendService;->instance:Lcom/alibaba/sdk/android/tbrest/SendService;

    return-object v0
.end method


# virtual methods
.method public changeHost(Ljava/lang/String;)V
    .locals 0

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->host:Ljava/lang/String;

    :cond_0
    return-void
.end method

.method public getAppKey()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->appKey:Ljava/lang/String;

    return-object v0
.end method

.method public getChangeHost()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->host:Ljava/lang/String;

    return-object v0
.end method

.method public getNoCollectionDataType()I
    .locals 1

    iget v0, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->noCollectionDataType:I

    return v0
.end method

.method public init(Landroid/content/Context;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->context:Landroid/content/Context;

    iput-object p2, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->appId:Ljava/lang/String;

    iput-object p3, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->appKey:Ljava/lang/String;

    iput-object p4, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->appVersion:Ljava/lang/String;

    iput-object p5, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->channel:Ljava/lang/String;

    iput-object p6, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->userNick:Ljava/lang/String;

    return-void
.end method

.method public sendRequest(Ljava/lang/String;JLjava/lang/String;ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/util/Map;)Ljava/lang/Boolean;
    .locals 13
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "J",
            "Ljava/lang/String;",
            "I",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/lang/Boolean;"
        }
    .end annotation

    move-object v12, p0

    .line 161
    invoke-direct {p0}, Lcom/alibaba/sdk/android/tbrest/SendService;->canSend()Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_2

    if-nez p1, :cond_1

    iget-object v0, v12, Lcom/alibaba/sdk/android/tbrest/SendService;->host:Ljava/lang/String;

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const-string v0, "h-adashx.ut.taobao.com"

    :goto_0
    move-object v3, v0

    goto :goto_1

    :cond_1
    move-object v3, p1

    :goto_1
    iget-object v1, v12, Lcom/alibaba/sdk/android/tbrest/SendService;->appKey:Ljava/lang/String;

    iget-object v2, v12, Lcom/alibaba/sdk/android/tbrest/SendService;->context:Landroid/content/Context;

    move-object v0, p0

    move-wide v4, p2

    move-object/from16 v6, p4

    move/from16 v7, p5

    move-object/from16 v8, p6

    move-object/from16 v9, p7

    move-object/from16 v10, p8

    move-object/from16 v11, p9

    .line 169
    invoke-static/range {v0 .. v11}, Lcom/alibaba/sdk/android/tbrest/rest/e;->a(Lcom/alibaba/sdk/android/tbrest/SendService;Ljava/lang/String;Landroid/content/Context;Ljava/lang/String;JLjava/lang/String;ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/util/Map;)Z

    move-result v0

    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0

    :cond_2
    const/4 v0, 0x0

    .line 172
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    return-object v0
.end method

.method public sendRequestAsyn(Ljava/lang/String;JLjava/lang/String;ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/util/Map;)V
    .locals 18
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "J",
            "Ljava/lang/String;",
            "I",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    move-object/from16 v15, p0

    .line 181
    invoke-direct/range {p0 .. p0}, Lcom/alibaba/sdk/android/tbrest/SendService;->canSend()Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_2

    if-nez p1, :cond_1

    iget-object v0, v15, Lcom/alibaba/sdk/android/tbrest/SendService;->host:Ljava/lang/String;

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    const-string v0, "h-adashx.ut.taobao.com"

    :goto_0
    move-object v5, v0

    goto :goto_1

    :cond_1
    move-object/from16 v5, p1

    .line 190
    :goto_1
    new-instance v14, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;

    const-string v2, "rest thread"

    iget-object v3, v15, Lcom/alibaba/sdk/android/tbrest/SendService;->appKey:Ljava/lang/String;

    iget-object v4, v15, Lcom/alibaba/sdk/android/tbrest/SendService;->context:Landroid/content/Context;

    const/4 v0, 0x0

    .line 192
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v16

    move-object v0, v14

    move-object/from16 v1, p0

    move-wide/from16 v6, p2

    move-object/from16 v8, p4

    move/from16 v9, p5

    move-object/from16 v10, p6

    move-object/from16 v11, p7

    move-object/from16 v12, p8

    move-object/from16 v13, p9

    move-object/from16 v17, v14

    move-object/from16 v14, v16

    invoke-direct/range {v0 .. v14}, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;-><init>(Lcom/alibaba/sdk/android/tbrest/SendService;Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;Ljava/lang/String;JLjava/lang/String;ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/util/Map;Ljava/lang/Boolean;)V

    iget-object v0, v15, Lcom/alibaba/sdk/android/tbrest/SendService;->sendAsyncExecutor:Lcom/alibaba/sdk/android/tbrest/a;

    move-object/from16 v1, v17

    .line 193
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/tbrest/a;->a(Ljava/lang/Runnable;)V

    :cond_2
    return-void
.end method

.method public sendRequestAsynByAppkeyAndUrl(Ljava/lang/String;Ljava/lang/String;JLjava/lang/String;ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/util/Map;)V
    .locals 18
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "J",
            "Ljava/lang/String;",
            "I",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)V"
        }
    .end annotation

    move-object/from16 v15, p0

    .line 204
    invoke-direct/range {p0 .. p0}, Lcom/alibaba/sdk/android/tbrest/SendService;->canSend()Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_2

    if-nez p1, :cond_0

    const-string v0, "RestApi"

    const-string v1, "need set url"

    .line 206
    invoke-static {v0, v1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    return-void

    :cond_0
    if-nez p2, :cond_1

    iget-object v0, v15, Lcom/alibaba/sdk/android/tbrest/SendService;->appKey:Ljava/lang/String;

    move-object v3, v0

    goto :goto_0

    :cond_1
    move-object/from16 v3, p2

    .line 212
    :goto_0
    new-instance v14, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;

    const-string v2, "rest thread"

    iget-object v4, v15, Lcom/alibaba/sdk/android/tbrest/SendService;->context:Landroid/content/Context;

    const/4 v0, 0x1

    .line 214
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v16

    move-object v0, v14

    move-object/from16 v1, p0

    move-object/from16 v5, p1

    move-wide/from16 v6, p3

    move-object/from16 v8, p5

    move/from16 v9, p6

    move-object/from16 v10, p7

    move-object/from16 v11, p8

    move-object/from16 v12, p9

    move-object/from16 v13, p10

    move-object/from16 v17, v14

    move-object/from16 v14, v16

    invoke-direct/range {v0 .. v14}, Lcom/alibaba/sdk/android/tbrest/SendService$RestThread;-><init>(Lcom/alibaba/sdk/android/tbrest/SendService;Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;Ljava/lang/String;JLjava/lang/String;ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/util/Map;Ljava/lang/Boolean;)V

    iget-object v0, v15, Lcom/alibaba/sdk/android/tbrest/SendService;->sendAsyncExecutor:Lcom/alibaba/sdk/android/tbrest/a;

    move-object/from16 v1, v17

    .line 215
    invoke-virtual {v0, v1}, Lcom/alibaba/sdk/android/tbrest/a;->a(Ljava/lang/Runnable;)V

    :cond_2
    return-void
.end method

.method public sendRequestByUrl(Ljava/lang/String;JLjava/lang/String;ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/util/Map;)Ljava/lang/String;
    .locals 13
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "J",
            "Ljava/lang/String;",
            "I",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            "Ljava/lang/Object;",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            ">;)",
            "Ljava/lang/String;"
        }
    .end annotation

    .annotation runtime Ljava/lang/Deprecated;
    .end annotation

    move-object v12, p0

    .line 226
    invoke-direct {p0}, Lcom/alibaba/sdk/android/tbrest/SendService;->canSend()Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v2, v12, Lcom/alibaba/sdk/android/tbrest/SendService;->appKey:Ljava/lang/String;

    iget-object v3, v12, Lcom/alibaba/sdk/android/tbrest/SendService;->context:Landroid/content/Context;

    move-object v0, p0

    move-object v1, p1

    move-wide v4, p2

    move-object/from16 v6, p4

    move/from16 v7, p5

    move-object/from16 v8, p6

    move-object/from16 v9, p7

    move-object/from16 v10, p8

    move-object/from16 v11, p9

    .line 227
    invoke-static/range {v0 .. v11}, Lcom/alibaba/sdk/android/tbrest/rest/e;->a(Lcom/alibaba/sdk/android/tbrest/SendService;Ljava/lang/String;Ljava/lang/String;Landroid/content/Context;JLjava/lang/String;ILjava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;Ljava/util/Map;)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public setNoCollectionDataType(I)V
    .locals 0

    iput p1, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->noCollectionDataType:I

    return-void
.end method

.method public updateAppVersion(Ljava/lang/String;)V
    .locals 0

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->appVersion:Ljava/lang/String;

    :cond_0
    return-void
.end method

.method public updateChannel(Ljava/lang/String;)V
    .locals 0

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->channel:Ljava/lang/String;

    :cond_0
    return-void
.end method

.method public updateUserNick(Ljava/lang/String;)V
    .locals 0

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/alibaba/sdk/android/tbrest/SendService;->userNick:Ljava/lang/String;

    :cond_0
    return-void
.end method
