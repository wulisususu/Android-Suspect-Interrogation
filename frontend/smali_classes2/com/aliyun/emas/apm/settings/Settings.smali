.class public Lcom/aliyun/emas/apm/settings/Settings;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/settings/Settings$a;
    }
.end annotation


# instance fields
.field public eventRules:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lcom/aliyun/emas/apm/settings/Settings$a;",
            ">;"
        }
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/util/List;)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/aliyun/emas/apm/settings/Settings$a;",
            ">;)V"
        }
    .end annotation

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/settings/Settings;->eventRules:Ljava/util/List;

    return-void
.end method


# virtual methods
.method public isCrashEnabled()Z
    .locals 5

    iget-object v0, p0, Lcom/aliyun/emas/apm/settings/Settings;->eventRules:Ljava/util/List;

    const/4 v1, 0x0

    if-eqz v0, :cond_2

    .line 1
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result v0

    if-eqz v0, :cond_0

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/aliyun/emas/apm/settings/Settings;->eventRules:Ljava/util/List;

    .line 5
    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lcom/aliyun/emas/apm/settings/Settings$a;

    .line 6
    iget-object v3, v2, Lcom/aliyun/emas/apm/settings/Settings$a;->b:Ljava/lang/String;

    const-string v4, "crash"

    invoke-static {v4, v3}, Landroid/text/TextUtils;->equals(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Z

    move-result v3

    if-eqz v3, :cond_1

    .line 7
    iget-boolean v0, v2, Lcom/aliyun/emas/apm/settings/Settings$a;->a:Z

    return v0

    :cond_2
    :goto_0
    return v1
.end method
