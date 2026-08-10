.class public Lcom/taobao/tao/log/godeye/core/a/a;
.super Ljava/lang/Object;
.source "GodeyeCommandManager.java"

# interfaces
.implements Lcom/taobao/tao/log/godeye/api/a/a;


# instance fields
.field private final mContext:Landroid/content/Context;


# direct methods
.method public constructor <init>(Landroid/content/Context;)V
    .locals 0

    .line 22
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/taobao/tao/log/godeye/core/a/a;->mContext:Landroid/content/Context;

    return-void
.end method


# virtual methods
.method public a(Lcom/taobao/tao/log/godeye/api/b/a;)Lcom/taobao/tao/log/godeye/api/a/e;
    .locals 3

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/a/a;->mContext:Landroid/content/Context;

    const-string v1, "godeye_command_config"

    const/4 v2, 0x0

    .line 28
    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 29
    iget-object p1, p1, Lcom/taobao/tao/log/godeye/api/b/a;->opCode:Ljava/lang/String;

    const/4 v1, 0x0

    invoke-interface {v0, p1, v1}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    if-eqz p1, :cond_0

    .line 32
    :try_start_0
    const-class v0, Lcom/taobao/tao/log/godeye/api/a/e;

    invoke-static {p1, v0}, Lcom/alibaba/fastjson/JSONObject;->parseObject(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Lcom/taobao/tao/log/godeye/api/a/e;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    move-exception p1

    .line 34
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :cond_0
    return-object v1
.end method

.method public a(Lcom/taobao/tao/log/godeye/api/b/a;Lcom/taobao/tao/log/godeye/api/a/e;)V
    .locals 3

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/a/a;->mContext:Landroid/content/Context;

    const-string v1, "godeye_command_config"

    const/4 v2, 0x0

    .line 42
    invoke-virtual {v0, v1, v2}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object v0

    .line 43
    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    .line 46
    :try_start_0
    invoke-static {p2}, Lcom/alibaba/fastjson/JSONObject;->toJSONString(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object p2

    .line 47
    iget-object p1, p1, Lcom/taobao/tao/log/godeye/api/b/a;->opCode:Ljava/lang/String;

    invoke-interface {v0, p1, p2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    .line 48
    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :catch_0
    move-exception p1

    .line 50
    invoke-virtual {p1}, Ljava/lang/Exception;->printStackTrace()V

    :goto_0
    return-void
.end method
