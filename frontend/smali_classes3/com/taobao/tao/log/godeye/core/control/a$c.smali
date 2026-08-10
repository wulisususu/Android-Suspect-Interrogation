.class Lcom/taobao/tao/log/godeye/core/control/a$c;
.super Landroid/content/BroadcastReceiver;
.source "GodeyeJointPointCenter.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/tao/log/godeye/core/control/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "c"
.end annotation


# instance fields
.field private final a:Lcom/taobao/tao/log/godeye/api/b/c$a;

.field private final mContext:Landroid/content/Context;


# direct methods
.method constructor <init>(Landroid/content/Context;Lcom/taobao/tao/log/godeye/api/b/c$a;)V
    .locals 0

    .line 313
    invoke-direct {p0}, Landroid/content/BroadcastReceiver;-><init>()V

    iput-object p1, p0, Lcom/taobao/tao/log/godeye/core/control/a$c;->mContext:Landroid/content/Context;

    iput-object p2, p0, Lcom/taobao/tao/log/godeye/core/control/a$c;->a:Lcom/taobao/tao/log/godeye/api/b/c$a;

    return-void
.end method


# virtual methods
.method public onReceive(Landroid/content/Context;Landroid/content/Intent;)V
    .locals 0

    iget-object p1, p0, Lcom/taobao/tao/log/godeye/core/control/a$c;->a:Lcom/taobao/tao/log/godeye/api/b/c$a;

    .line 320
    invoke-virtual {p1}, Lcom/taobao/tao/log/godeye/api/b/c$a;->b()V

    iget-object p1, p0, Lcom/taobao/tao/log/godeye/core/control/a$c;->a:Lcom/taobao/tao/log/godeye/api/b/c$a;

    .line 321
    invoke-virtual {p1}, Lcom/taobao/tao/log/godeye/api/b/c$a;->a()Z

    move-result p1

    if-eqz p1, :cond_0

    iget-object p1, p0, Lcom/taobao/tao/log/godeye/core/control/a$c;->mContext:Landroid/content/Context;

    .line 322
    invoke-virtual {p1, p0}, Landroid/content/Context;->unregisterReceiver(Landroid/content/BroadcastReceiver;)V

    :cond_0
    return-void
.end method
