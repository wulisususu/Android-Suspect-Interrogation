.class public Lcom/taobao/monitor/impl/data/o/d;
.super Ljava/lang/Object;
.source "GCSwitcher.java"

# interfaces
.implements Lcom/taobao/monitor/impl/trace/e$b;
.implements Lcom/taobao/monitor/impl/trace/d$b;


# instance fields
.field private volatile a:Z


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/o/d;->a:Z

    return-void
.end method

.method private c()V
    .locals 1

    .line 1
    new-instance v0, Lcom/taobao/monitor/impl/data/o/b;

    invoke-direct {v0}, Lcom/taobao/monitor/impl/data/o/b;-><init>()V

    return-void
.end method


# virtual methods
.method public a()V
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/data/o/d;->a:Z

    if-eqz v0, :cond_0

    .line 2
    invoke-direct {p0}, Lcom/taobao/monitor/impl/data/o/d;->c()V

    :cond_0
    return-void
.end method

.method public a(IJ)V
    .locals 0

    if-nez p1, :cond_0

    .line 3
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/data/o/d;->d()V

    goto :goto_0

    .line 5
    :cond_0
    invoke-virtual {p0}, Lcom/taobao/monitor/impl/data/o/d;->b()V

    :goto_0
    return-void
.end method

.method public b()V
    .locals 1

    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/o/d;->a:Z

    return-void
.end method

.method public d()V
    .locals 1

    iget-boolean v0, p0, Lcom/taobao/monitor/impl/data/o/d;->a:Z

    if-nez v0, :cond_0

    const/4 v0, 0x1

    iput-boolean v0, p0, Lcom/taobao/monitor/impl/data/o/d;->a:Z

    .line 3
    invoke-direct {p0}, Lcom/taobao/monitor/impl/data/o/d;->c()V

    :cond_0
    return-void
.end method
