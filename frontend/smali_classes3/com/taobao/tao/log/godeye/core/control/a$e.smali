.class Lcom/taobao/tao/log/godeye/core/control/a$e;
.super Lcom/taobao/tao/log/godeye/api/b/c$a;
.source "GodeyeJointPointCenter.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/tao/log/godeye/core/control/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "e"
.end annotation


# instance fields
.field private final a:Lcom/taobao/tao/log/godeye/api/b/c$a;


# direct methods
.method public constructor <init>(Lcom/taobao/tao/log/godeye/api/b/c$a;)V
    .locals 0

    .line 491
    invoke-direct {p0}, Lcom/taobao/tao/log/godeye/api/b/c$a;-><init>()V

    iput-object p1, p0, Lcom/taobao/tao/log/godeye/core/control/a$e;->a:Lcom/taobao/tao/log/godeye/api/b/c$a;

    return-void
.end method


# virtual methods
.method public a()Z
    .locals 1

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/a$e;->a:Lcom/taobao/tao/log/godeye/api/b/c$a;

    .line 497
    invoke-virtual {v0}, Lcom/taobao/tao/log/godeye/api/b/c$a;->a()Z

    move-result v0

    return v0
.end method

.method public b()V
    .locals 5

    .line 502
    invoke-static {}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->sharedInstance()Lcom/taobao/tao/log/godeye/core/control/Godeye;

    move-result-object v0

    new-instance v1, Lcom/taobao/tao/log/godeye/a/b/a;

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v2

    invoke-static {v2, v3}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object v2

    const-string v3, "global_end"

    const/4 v4, 0x0

    invoke-direct {v1, v2, v3, v4}, Lcom/taobao/tao/log/godeye/a/b/a;-><init>(Ljava/lang/Long;Ljava/lang/String;Ljava/lang/Object;)V

    invoke-virtual {v0, v1}, Lcom/taobao/tao/log/godeye/core/control/Godeye;->addClientEvent(Lcom/taobao/tao/log/godeye/a/b/a;)V

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/a$e;->a:Lcom/taobao/tao/log/godeye/api/b/c$a;

    .line 503
    invoke-virtual {v0}, Lcom/taobao/tao/log/godeye/api/b/c$a;->b()V

    return-void
.end method
