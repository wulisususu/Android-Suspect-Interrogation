.class Lcom/aliyun/emas/apm/f$a$a;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Ljava/lang/Runnable;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/aliyun/emas/apm/f$a;->a(Lcom/aliyun/emas/apm/settings/Settings;)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation


# instance fields
.field final synthetic a:Lcom/aliyun/emas/apm/f$a;


# direct methods
.method constructor <init>(Lcom/aliyun/emas/apm/f$a;)V
    .locals 0

    iput-object p1, p0, Lcom/aliyun/emas/apm/f$a$a;->a:Lcom/aliyun/emas/apm/f$a;

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public run()V
    .locals 5

    iget-object v0, p0, Lcom/aliyun/emas/apm/f$a$a;->a:Lcom/aliyun/emas/apm/f$a;

    .line 1
    iget-object v0, v0, Lcom/aliyun/emas/apm/f$a;->b:Lcom/aliyun/emas/apm/f;

    invoke-static {v0}, Lcom/aliyun/emas/apm/f;->a(Lcom/aliyun/emas/apm/f;)Ljava/lang/Object;

    move-result-object v0

    monitor-enter v0

    :try_start_0
    iget-object v1, p0, Lcom/aliyun/emas/apm/f$a$a;->a:Lcom/aliyun/emas/apm/f$a;

    .line 2
    iget-object v2, v1, Lcom/aliyun/emas/apm/f$a;->b:Lcom/aliyun/emas/apm/f;

    iget-object v1, v1, Lcom/aliyun/emas/apm/f$a;->a:Ljava/lang/Long;

    invoke-static {v2, v1}, Lcom/aliyun/emas/apm/f;->a(Lcom/aliyun/emas/apm/f;Ljava/lang/Long;)Ljava/util/List;

    move-result-object v1

    .line 3
    invoke-interface {v1}, Ljava/util/List;->isEmpty()Z

    move-result v2

    if-eqz v2, :cond_0

    .line 4
    monitor-exit v0

    return-void

    :cond_0
    iget-object v2, p0, Lcom/aliyun/emas/apm/f$a$a;->a:Lcom/aliyun/emas/apm/f$a;

    .line 7
    iget-object v2, v2, Lcom/aliyun/emas/apm/f$a;->b:Lcom/aliyun/emas/apm/f;

    invoke-static {v2, v1}, Lcom/aliyun/emas/apm/f;->a(Lcom/aliyun/emas/apm/f;Ljava/util/List;)Z

    move-result v1

    if-eqz v1, :cond_1

    iget-object v1, p0, Lcom/aliyun/emas/apm/f$a$a;->a:Lcom/aliyun/emas/apm/f$a;

    .line 9
    iget-object v1, v1, Lcom/aliyun/emas/apm/f$a;->b:Lcom/aliyun/emas/apm/f;

    const/4 v2, 0x0

    invoke-static {v1, v2}, Lcom/aliyun/emas/apm/f;->b(Lcom/aliyun/emas/apm/f;Ljava/util/List;)V

    goto :goto_0

    :cond_1
    iget-object v1, p0, Lcom/aliyun/emas/apm/f$a$a;->a:Lcom/aliyun/emas/apm/f$a;

    .line 12
    iget-object v1, v1, Lcom/aliyun/emas/apm/f$a;->a:Ljava/lang/Long;

    if-eqz v1, :cond_2

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v1

    const-wide/16 v3, 0x0

    cmp-long v1, v1, v3

    if-lez v1, :cond_2

    iget-object v1, p0, Lcom/aliyun/emas/apm/f$a$a;->a:Lcom/aliyun/emas/apm/f$a;

    .line 13
    iget-object v2, v1, Lcom/aliyun/emas/apm/f$a;->b:Lcom/aliyun/emas/apm/f;

    iget-object v1, v1, Lcom/aliyun/emas/apm/f$a;->a:Ljava/lang/Long;

    invoke-virtual {v1}, Ljava/lang/Long;->longValue()J

    move-result-wide v3

    invoke-static {v2, v3, v4}, Lcom/aliyun/emas/apm/f;->a(Lcom/aliyun/emas/apm/f;J)V

    .line 16
    :cond_2
    :goto_0
    monitor-exit v0

    return-void

    :catchall_0
    move-exception v1

    .line 17
    monitor-exit v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    throw v1
.end method
