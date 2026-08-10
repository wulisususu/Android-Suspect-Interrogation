.class final Lcom/aliyun/emas/apm/crash/internal/model/x$b;
.super Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState$Builder;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/x;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = "b"
.end annotation


# instance fields
.field private a:Ljava/util/List;


# direct methods
.method constructor <init>()V
    .locals 0

    .line 1
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState$Builder;-><init>()V

    return-void
.end method


# virtual methods
.method public build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState;
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/internal/model/x$b;->a:Ljava/util/List;

    if-eqz v0, :cond_0

    .line 5
    new-instance v1, Lcom/aliyun/emas/apm/crash/internal/model/x;

    const/4 v2, 0x0

    invoke-direct {v1, v0, v2}, Lcom/aliyun/emas/apm/crash/internal/model/x;-><init>(Ljava/util/List;Lcom/aliyun/emas/apm/crash/internal/model/x$a;)V

    return-object v1

    .line 6
    :cond_0
    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "Missing required properties: rolloutAssignments"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0
.end method

.method public setRolloutAssignments(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState$Builder;
    .locals 1

    if-eqz p1, :cond_0

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/internal/model/x$b;->a:Ljava/util/List;

    return-object p0

    .line 2
    :cond_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "Null rolloutAssignments"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1
.end method
