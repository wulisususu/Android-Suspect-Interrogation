.class Lcom/taobao/tao/log/godeye/core/control/a$f;
.super Lcom/taobao/tao/log/godeye/api/b/c$a;
.source "GodeyeJointPointCenter.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/taobao/tao/log/godeye/core/control/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0xa
    name = "f"
.end annotation


# instance fields
.field private final b:J

.field private final b:Lcom/taobao/tao/log/godeye/api/b/c$a;

.field private final c:Lcom/taobao/tao/log/godeye/api/b/c$a;


# direct methods
.method constructor <init>(JLcom/taobao/tao/log/godeye/api/b/c$a;Lcom/taobao/tao/log/godeye/api/b/c$a;)V
    .locals 0

    .line 429
    invoke-direct {p0}, Lcom/taobao/tao/log/godeye/api/b/c$a;-><init>()V

    iput-wide p1, p0, Lcom/taobao/tao/log/godeye/core/control/a$f;->b:J

    iput-object p3, p0, Lcom/taobao/tao/log/godeye/core/control/a$f;->b:Lcom/taobao/tao/log/godeye/api/b/c$a;

    iput-object p4, p0, Lcom/taobao/tao/log/godeye/core/control/a$f;->c:Lcom/taobao/tao/log/godeye/api/b/c$a;

    return-void
.end method


# virtual methods
.method public b()V
    .locals 4

    iget-object v0, p0, Lcom/taobao/tao/log/godeye/core/control/a$f;->b:Lcom/taobao/tao/log/godeye/api/b/c$a;

    .line 437
    invoke-virtual {v0}, Lcom/taobao/tao/log/godeye/api/b/c$a;->b()V

    iget-wide v0, p0, Lcom/taobao/tao/log/godeye/core/control/a$f;->b:J

    const-wide/16 v2, 0x0

    cmp-long v0, v0, v2

    if-lez v0, :cond_0

    .line 439
    new-instance v0, Lcom/taobao/tao/log/godeye/core/control/a$a;

    iget-object v1, p0, Lcom/taobao/tao/log/godeye/core/control/a$f;->c:Lcom/taobao/tao/log/godeye/api/b/c$a;

    invoke-direct {v0, v1}, Lcom/taobao/tao/log/godeye/core/control/a$a;-><init>(Lcom/taobao/tao/log/godeye/api/b/c$a;)V

    const/4 v1, 0x0

    iget-wide v2, p0, Lcom/taobao/tao/log/godeye/core/control/a$f;->b:J

    invoke-virtual {v0, v1, v2, v3}, Lcom/taobao/tao/log/godeye/core/control/a$a;->sendEmptyMessageDelayed(IJ)Z

    :cond_0
    return-void
.end method
