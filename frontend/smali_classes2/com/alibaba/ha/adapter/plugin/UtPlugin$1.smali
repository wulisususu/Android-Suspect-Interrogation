.class public Lcom/alibaba/ha/adapter/plugin/UtPlugin$1;
.super Ljava/lang/Object;
.source "UtPlugin.java"

# interfaces
.implements Lcom/ut/mini/IUTApplication;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/alibaba/ha/adapter/plugin/UtPlugin;->start(Lcom/alibaba/ha/protocol/AliHaParam;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1
    name = null
.end annotation


# instance fields
.field public final synthetic this$0:Lcom/alibaba/ha/adapter/plugin/UtPlugin;

.field public final synthetic val$appId:Ljava/lang/String;

.field public final synthetic val$appKey:Ljava/lang/String;

.field public final synthetic val$appSecret:Ljava/lang/String;

.field public final synthetic val$appVersion:Ljava/lang/String;

.field public final synthetic val$param:Lcom/alibaba/ha/protocol/AliHaParam;


# direct methods
.method public constructor <init>(Lcom/alibaba/ha/adapter/plugin/UtPlugin;Ljava/lang/String;Lcom/alibaba/ha/protocol/AliHaParam;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/alibaba/ha/adapter/plugin/UtPlugin$1;->this$0:Lcom/alibaba/ha/adapter/plugin/UtPlugin;

    iput-object p2, p0, Lcom/alibaba/ha/adapter/plugin/UtPlugin$1;->val$appVersion:Ljava/lang/String;

    iput-object p3, p0, Lcom/alibaba/ha/adapter/plugin/UtPlugin$1;->val$param:Lcom/alibaba/ha/protocol/AliHaParam;

    iput-object p4, p0, Lcom/alibaba/ha/adapter/plugin/UtPlugin$1;->val$appSecret:Ljava/lang/String;

    iput-object p5, p0, Lcom/alibaba/ha/adapter/plugin/UtPlugin$1;->val$appKey:Ljava/lang/String;

    iput-object p6, p0, Lcom/alibaba/ha/adapter/plugin/UtPlugin$1;->val$appId:Ljava/lang/String;

    .line 57
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getUTAppVersion()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/ha/adapter/plugin/UtPlugin$1;->val$appVersion:Ljava/lang/String;

    return-object v0
.end method

.method public getUTChannel()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/alibaba/ha/adapter/plugin/UtPlugin$1;->val$param:Lcom/alibaba/ha/protocol/AliHaParam;

    .line 66
    iget-object v0, v0, Lcom/alibaba/ha/protocol/AliHaParam;->channel:Ljava/lang/String;

    return-object v0
.end method

.method public getUTCrashCraughtListener()Lcom/ut/mini/crashhandler/IUTCrashCaughtListner;
    .locals 1

    const/4 v0, 0x0

    return-object v0
.end method

.method public getUTRequestAuthInstance()Lcom/ut/mini/core/sign/IUTRequestAuthentication;
    .locals 3

    iget-object v0, p0, Lcom/alibaba/ha/adapter/plugin/UtPlugin$1;->val$appSecret:Ljava/lang/String;

    if-eqz v0, :cond_0

    .line 72
    invoke-virtual {v0}, Ljava/lang/String;->length()I

    move-result v1

    if-nez v1, :cond_1

    .line 73
    :cond_0
    new-instance v0, Lcom/alibaba/ha/adapter/service/RandomService;

    invoke-direct {v0}, Lcom/alibaba/ha/adapter/service/RandomService;-><init>()V

    .line 74
    invoke-virtual {v0}, Lcom/alibaba/ha/adapter/service/RandomService;->getRandomNum()Ljava/lang/String;

    move-result-object v0

    if-nez v0, :cond_1

    const-string v0, "8951ae070be6560f4fc1401e90a83a4e"

    .line 79
    :cond_1
    new-instance v1, Lcom/ut/mini/core/sign/UTBaseRequestAuthentication;

    iget-object v2, p0, Lcom/alibaba/ha/adapter/plugin/UtPlugin$1;->val$appKey:Ljava/lang/String;

    invoke-direct {v1, v2, v0}, Lcom/ut/mini/core/sign/UTBaseRequestAuthentication;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    return-object v1
.end method

.method public isAliyunOsSystem()Z
    .locals 2

    iget-object v0, p0, Lcom/alibaba/ha/adapter/plugin/UtPlugin$1;->val$appId:Ljava/lang/String;

    const-string v1, "aliyunos"

    .line 91
    invoke-virtual {v0, v1}, Ljava/lang/String;->endsWith(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const/4 v0, 0x1

    return v0

    :cond_0
    const/4 v0, 0x0

    return v0
.end method

.method public isUTCrashHandlerDisable()Z
    .locals 2

    const-string v0, "AliHaAdapter"

    const-string v1, "close ut crash handler success"

    .line 104
    invoke-static {v0, v1}, Landroid/util/Log;->i(Ljava/lang/String;Ljava/lang/String;)I

    const/4 v0, 0x1

    return v0
.end method

.method public isUTLogEnable()Z
    .locals 1

    const/4 v0, 0x1

    return v0
.end method
