.class public Lcom/taobao/tao/log/godeye/core/control/Godeye;
.super Ljava/lang/Object;
.source "Godeye.java"

# interfaces
.implements Lcom/taobao/tao/log/godeye/api/b/b;


# static fields
.field public static final GODEYE_TAG:Ljava/lang/String; = "Godeye"

.field private static volatile instance:Lcom/taobao/tao/log/godeye/core/control/Godeye;


# instance fields
.field public godEyeAppListener:Lcom/taobao/tao/log/godeye/core/GodEyeAppListener;

.field public godEyeReponses:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Lcom/taobao/tao/log/godeye/core/GodEyeReponse;",
            ">;"
        }
    .end annotation
.end field

.field private mAppId:Ljava/lang/String;

.field private mAppVersion:Ljava/lang/String;

.field private mApplication:Landroid/app/Application;

.field private mBuildId:Ljava/lang/String;

.field private mClientEventQueue:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/taobao/tao/log/godeye/a/b/a;",
            ">;"
        }
    .end annotation
.end field

.field private mGodeyeCommandManager:Lcom/taobao/tao/log/godeye/core/a/a;

.field private mGodeyeJointPointCenter:Lcom/taobao/tao/log/godeye/core/control/a;

.field private mGodeyeOnDemandCallback:Lcom/taobao/tao/log/godeye/api/b/c$a;

.field private mGodeyeRemoteCommandCenter:Lcom/taobao/tao/log/godeye/core/a/b;

.field private mInitialized:Z

.field private mIsDebugMode:Z

.field public utdid:Ljava/lang/String;


# direct methods
.method private constructor <init>()V
    .locals 1

    .line 77
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 46
    new-instance v0, Ljava/util/concurrent/ConcurrentHashMap;

    invoke-direct {v0}, Ljava/util/concurrent/ConcurrentHashMap;-><init>()V

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->godEyeReponses:Ljava/util/Map;

    .line 59
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mClientEventQueue:Ljava/util/List;

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mInitialized:Z

    iput-boolean v0, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mIsDebugMode:Z

    return-void
.end method

.method private commandExecuteWhenInit()V
    .locals 5

    .line 126
    :try_start_0
    invoke-virtual {p0}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->defaultGodeyeRemoteCommandCenter()Lcom/taobao/tao/log/godeye/core/a/b;

    move-result-object v0

    invoke-virtual {v0}, Lcom/taobao/tao/log/godeye/core/a/b;->a()Ljava/util/Set;

    move-result-object v0

    if-eqz v0, :cond_2

    .line 127
    invoke-interface {v0}, Ljava/util/Set;->size()I

    move-result v1

    if-lez v1, :cond_2

    const/4 v1, 0x1

    iput-boolean v1, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mIsDebugMode:Z

    iget-object v2, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mGodeyeOnDemandCallback:Lcom/taobao/tao/log/godeye/api/b/c$a;

    if-eqz v2, :cond_0

    .line 130
    invoke-virtual {v2}, Lcom/taobao/tao/log/godeye/api/b/c$a;->b()V

    .line 133
    :cond_0
    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/taobao/tao/log/godeye/a/a/a$a;

    .line 134
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v3

    invoke-virtual {v3}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->defaultCommandManager()Lcom/taobao/tao/log/godeye/api/a/a;

    move-result-object v3

    invoke-virtual {v2}, Lcom/taobao/tao/log/godeye/a/a/a$a;->getValue()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lcom/taobao/tao/log/godeye/api/b/a;

    invoke-interface {v3, v4}, Lcom/taobao/tao/log/godeye/api/a/a;->a(Lcom/taobao/tao/log/godeye/api/b/a;)Lcom/taobao/tao/log/godeye/api/a/e;

    move-result-object v3

    if-eqz v3, :cond_1

    .line 136
    invoke-virtual {p0}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->defaultGodeyeRemoteCommandCenter()Lcom/taobao/tao/log/godeye/core/a/b;

    move-result-object v4

    invoke-virtual {v2}, Lcom/taobao/tao/log/godeye/a/a/a$a;->getValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/taobao/tao/log/godeye/api/b/a;

    invoke-virtual {v4, v2, v3, v1}, Lcom/taobao/tao/log/godeye/core/a/b;->a(Lcom/taobao/tao/log/godeye/api/b/a;Lcom/taobao/tao/log/godeye/api/a/e;Z)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception v0

    .line 141
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    :cond_2
    return-void
.end method

.method public static sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;
    .locals 1

    sget-object v0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->instance:Lcom/taobao/tao/log/godeye/core/control/Godeye;

    if-nez v0, :cond_0

    .line 84
    new-instance v0, Lcom/taobao/tao/log/godeye/core/control/Godeye;

    invoke-direct {v0}, Lcom/taobao/tao/log/godeye/core/control/Godeye;-><init>()V

    sput-object v0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->instance:Lcom/taobao/tao/log/godeye/core/control/Godeye;

    :cond_0
    sget-object v0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->instance:Lcom/taobao/tao/log/godeye/core/control/Godeye;

    return-object v0
.end method


# virtual methods
.method public addClientEvent(Lcom/taobao/tao/log/godeye/a/b/a;)V
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mClientEventQueue:Ljava/util/List;

    .line 321
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public defaultCommandManager()Lcom/taobao/tao/log/godeye/api/a/a;
    .locals 2

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mGodeyeCommandManager:Lcom/taobao/tao/log/godeye/core/a/a;

    if-nez v0, :cond_0

    .line 251
    new-instance v0, Lcom/taobao/tao/log/godeye/core/a/a;

    iget-object v1, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mApplication:Landroid/app/Application;

    invoke-direct {v0, v1}, Lcom/taobao/tao/log/godeye/core/a/a;-><init>(Landroid/content/Context;)V

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mGodeyeCommandManager:Lcom/taobao/tao/log/godeye/core/a/a;

    :cond_0
    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mGodeyeCommandManager:Lcom/taobao/tao/log/godeye/core/a/a;

    return-object v0
.end method

.method public bridge synthetic defaultGodeyeJointPointCenter()Lcom/taobao/tao/log/godeye/api/b/c;
    .locals 1

    .line 35
    invoke-virtual {p0}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->defaultGodeyeJointPointCenter()Lcom/taobao/tao/log/godeye/core/control/a;

    move-result-object v0

    return-object v0
.end method

.method public defaultGodeyeJointPointCenter()Lcom/taobao/tao/log/godeye/core/control/a;
    .locals 2

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mGodeyeJointPointCenter:Lcom/taobao/tao/log/godeye/core/control/a;

    if-nez v0, :cond_0

    .line 260
    new-instance v0, Lcom/taobao/tao/log/godeye/core/control/a;

    iget-object v1, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mApplication:Landroid/app/Application;

    invoke-direct {v0, v1}, Lcom/taobao/tao/log/godeye/core/control/a;-><init>(Landroid/app/Application;)V

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mGodeyeJointPointCenter:Lcom/taobao/tao/log/godeye/core/control/a;

    :cond_0
    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mGodeyeJointPointCenter:Lcom/taobao/tao/log/godeye/core/control/a;

    return-object v0
.end method

.method public defaultGodeyeRemoteCommandCenter()Lcom/taobao/tao/log/godeye/core/a/b;
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mGodeyeRemoteCommandCenter:Lcom/taobao/tao/log/godeye/core/a/b;

    if-nez v0, :cond_0

    .line 267
    new-instance v0, Lcom/taobao/tao/log/godeye/core/a/b;

    invoke-direct {v0}, Lcom/taobao/tao/log/godeye/core/a/b;-><init>()V

    iput-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mGodeyeRemoteCommandCenter:Lcom/taobao/tao/log/godeye/core/a/b;

    :cond_0
    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mGodeyeRemoteCommandCenter:Lcom/taobao/tao/log/godeye/core/a/b;

    return-object v0
.end method

.method public getAppVersion()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mAppVersion:Ljava/lang/String;

    return-object v0
.end method

.method public getApplication()Landroid/app/Application;
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mApplication:Landroid/app/Application;

    return-object v0
.end method

.method public getRuntimeStatData()Ljava/util/Map;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/Map<",
            "Ljava/lang/String;",
            "Ljava/lang/Object;",
            ">;"
        }
    .end annotation

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->godEyeAppListener:Lcom/taobao/tao/log/godeye/core/GodEyeAppListener;

    if-eqz v0, :cond_0

    .line 281
    :try_start_0
    invoke-interface {v0}, Lcom/taobao/tao/log/godeye/core/GodEyeAppListener;->getAppInfo()Ljava/util/Map;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    move-exception v0

    .line 283
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    goto :goto_0

    :cond_0
    const-string v0, "Godeye"

    const-string v1, "god eye app listener doesn\'t exist "

    .line 286
    invoke-static {v0, v1}, Landroid/util/Log;->w(Ljava/lang/String;Ljava/lang/String;)I

    :goto_0
    const/4 v0, 0x0

    :goto_1
    if-nez v0, :cond_1

    .line 290
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    :cond_1
    return-object v0
.end method

.method public handleRemoteCommand(Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;)Z
    .locals 3

    const/4 v0, 0x0

    if-eqz p1, :cond_1

    .line 152
    iget-object v1, p1, Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;->commandInfo:Lcom/taobao/android/tlog/protocol/model/CommandInfo;

    if-nez v1, :cond_0

    goto :goto_0

    :cond_0
    const/4 v1, 0x1

    :try_start_0
    iput-boolean v1, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mIsDebugMode:Z

    .line 157
    invoke-virtual {p0}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->defaultGodeyeRemoteCommandCenter()Lcom/taobao/tao/log/godeye/core/a/b;

    move-result-object v2

    invoke-virtual {v2, p1}, Lcom/taobao/tao/log/godeye/core/a/b;->b(Lcom/taobao/android/tlog/protocol/model/GodeyeInfo;)V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return v1

    :catch_0
    move-exception p1

    .line 161
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :cond_1
    :goto_0
    return v0
.end method

.method public initialize(Landroid/app/Application;Ljava/lang/String;Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mApplication:Landroid/app/Application;

    iput-object p2, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mAppId:Ljava/lang/String;

    iput-object p3, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mAppVersion:Ljava/lang/String;

    .line 101
    :try_start_0
    invoke-static {p1}, Lcom/taobao/tao/log/godeye/core/b/a;->a(Landroid/app/Application;)V

    iget-object p1, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mGodeyeJointPointCenter:Lcom/taobao/tao/log/godeye/core/control/a;

    if-nez p1, :cond_0

    .line 104
    invoke-virtual {p0}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->defaultGodeyeJointPointCenter()Lcom/taobao/tao/log/godeye/core/control/a;

    move-result-object p1

    iput-object p1, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mGodeyeJointPointCenter:Lcom/taobao/tao/log/godeye/core/control/a;

    .line 108
    :cond_0
    invoke-direct {p0}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->commandExecuteWhenInit()V

    const/4 p1, 0x1

    iput-boolean p1, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mInitialized:Z
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 112
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :goto_0
    return-void
.end method

.method public isDebugMode()Z
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mIsDebugMode:Z

    return v0
.end method

.method public isInitialized()Z
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mInitialized:Z

    return v0
.end method

.method public registerCommandController(Lcom/taobao/tao/log/godeye/api/b/a;)V
    .locals 2

    .line 147
    invoke-virtual {p0}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->defaultGodeyeRemoteCommandCenter()Lcom/taobao/tao/log/godeye/core/a/b;

    move-result-object v0

    iget-object v1, p1, Lcom/taobao/tao/log/godeye/api/b/a;->opCode:Ljava/lang/String;

    invoke-virtual {v0, v1, p1}, Lcom/taobao/tao/log/godeye/core/a/b;->a(Ljava/lang/String;Lcom/taobao/tao/log/godeye/api/b/a;)V

    return-void
.end method

.method public response(Lcom/taobao/tao/log/godeye/api/b/a;Lcom/taobao/tao/log/godeye/api/a/c;)V
    .locals 9

    const-string v0, "Godeye"

    if-nez p2, :cond_0

    return-void

    .line 171
    :cond_0
    iget-object v1, p2, Lcom/taobao/tao/log/godeye/api/a/c;->a:Lcom/alibaba/fastjson/JSONObject;

    if-nez v1, :cond_1

    .line 172
    new-instance v1, Lcom/alibaba/fastjson/JSONObject;

    invoke-direct {v1}, Lcom/alibaba/fastjson/JSONObject;-><init>()V

    iput-object v1, p2, Lcom/taobao/tao/log/godeye/api/a/c;->a:Lcom/alibaba/fastjson/JSONObject;

    .line 176
    :cond_1
    iget-object v1, p2, Lcom/taobao/tao/log/godeye/api/a/c;->a:Lcom/alibaba/fastjson/JSONObject;

    const-string v2, "appBuild"

    iget-object v3, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mBuildId:Ljava/lang/String;

    invoke-virtual {v1, v2, v3}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    .line 181
    iget v1, p2, Lcom/taobao/tao/log/godeye/api/a/c;->responseCode:I

    const/4 v2, 0x5

    if-ne v1, v2, :cond_2

    .line 182
    invoke-virtual {p0}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->getRuntimeStatData()Ljava/util/Map;

    move-result-object v1

    .line 183
    iget-object v3, p2, Lcom/taobao/tao/log/godeye/api/a/c;->a:Lcom/alibaba/fastjson/JSONObject;

    const-string v4, "statData"

    invoke-virtual {v3, v4, v1}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    .line 184
    iget-object v1, p2, Lcom/taobao/tao/log/godeye/api/a/c;->a:Lcom/alibaba/fastjson/JSONObject;

    const-string v3, "clientEventQueue"

    iget-object v4, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mClientEventQueue:Ljava/util/List;

    invoke-virtual {v1, v3, v4}, Lcom/alibaba/fastjson/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Ljava/lang/Object;

    iget-object v1, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mApplication:Landroid/app/Application;

    .line 185
    invoke-static {v1}, Lcom/taobao/tao/log/godeye/core/b/a;->b(Landroid/app/Application;)V

    .line 189
    :cond_2
    iget v1, p2, Lcom/taobao/tao/log/godeye/api/a/c;->responseCode:I

    const/4 v3, 0x7

    if-eq v1, v3, :cond_3

    iget v1, p2, Lcom/taobao/tao/log/godeye/api/a/c;->responseCode:I

    if-ne v1, v2, :cond_5

    .line 192
    :cond_3
    :try_start_0
    iget-object v1, p1, Lcom/taobao/tao/log/godeye/api/b/a;->opCode:Ljava/lang/String;

    .line 193
    invoke-virtual {p1}, Lcom/taobao/tao/log/godeye/api/b/a;->b()Ljava/lang/String;

    move-result-object v3

    .line 194
    invoke-virtual {p1}, Lcom/taobao/tao/log/godeye/api/b/a;->a()Ljava/lang/String;

    move-result-object v4

    if-eqz v1, :cond_4

    iget-object p1, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->godEyeReponses:Ljava/util/Map;

    .line 196
    invoke-interface {p1, v1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    move-object v2, p1

    check-cast v2, Lcom/taobao/tao/log/godeye/core/GodEyeReponse;

    if-eqz v2, :cond_5

    .line 198
    iget-object v5, p2, Lcom/taobao/tao/log/godeye/api/a/c;->a:Lcom/alibaba/fastjson/JSONObject;

    const-string v6, "godeye"

    iget p1, p2, Lcom/taobao/tao/log/godeye/api/a/c;->responseCode:I

    .line 199
    invoke-static {p1}, Ljava/lang/String;->valueOf(I)Ljava/lang/String;

    move-result-object v7

    iget-object v8, p2, Lcom/taobao/tao/log/godeye/api/a/c;->f:Ljava/lang/String;

    .line 198
    invoke-interface/range {v2 .. v8}, Lcom/taobao/tao/log/godeye/core/GodEyeReponse;->execute(Ljava/lang/String;Ljava/lang/String;Lcom/alibaba/fastjson/JSONObject;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    :cond_4
    const-string p1, "you need regist god eye reponse"

    .line 202
    invoke-static {v0, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 206
    invoke-virtual {p1}, Ljava/lang/Exception;->getMessage()Ljava/lang/String;

    move-result-object p2

    invoke-static {v0, p2, p1}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;Ljava/lang/Throwable;)I

    :cond_5
    :goto_0
    return-void
.end method

.method public setBuildId(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mBuildId:Ljava/lang/String;

    return-void
.end method

.method public setGodeyeOnDemandCallback(Lcom/taobao/tao/log/godeye/api/b/c$a;)V
    .locals 0

    iput-object p1, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->mGodeyeOnDemandCallback:Lcom/taobao/tao/log/godeye/api/b/c$a;

    return-void
.end method

.method public upload(Lcom/taobao/tao/log/godeye/api/b/a;Ljava/lang/String;Lcom/taobao/tao/log/godeye/api/file/FileUploadListener;)V
    .locals 2

    .line 235
    iget-object v0, p1, Lcom/taobao/tao/log/godeye/api/b/a;->opCode:Ljava/lang/String;

    .line 236
    invoke-virtual {p1}, Lcom/taobao/tao/log/godeye/api/b/a;->a()Ljava/lang/String;

    move-result-object p1

    if-eqz v0, :cond_1

    iget-object v1, p0, Lcom/taobao/tao/log/godeye/core/control/Godeye;->godEyeReponses:Ljava/util/Map;

    .line 238
    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/taobao/tao/log/godeye/core/GodEyeReponse;

    if-eqz v0, :cond_0

    .line 240
    invoke-interface {v0, p1, p2, p3}, Lcom/taobao/tao/log/godeye/core/GodEyeReponse;->sendFile(Ljava/lang/String;Ljava/lang/String;Lcom/taobao/tao/log/godeye/api/file/FileUploadListener;)V

    goto :goto_0

    :cond_0
    const-string p1, "Godeye"

    const-string p2, "you need regist god eye reponse"

    .line 242
    invoke-static {p1, p2}, Landroid/util/Log;->e(Ljava/lang/String;Ljava/lang/String;)I

    :cond_1
    :goto_0
    return-void
.end method
