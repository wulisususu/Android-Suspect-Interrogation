.class public abstract Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Session"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;,
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;,
        Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;
    }
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;
    .locals 2

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/l$b;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/crash/internal/model/l$b;-><init>()V

    const/4 v1, 0x0

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/l$b;->setCrashed(Z)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method a(JZ)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;
    .locals 1

    .line 3
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->toBuilder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;

    move-result-object v0

    .line 4
    invoke-static {p1, p2}, Ljava/lang/Long;->valueOf(J)Ljava/lang/Long;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;->setEndedAt(Ljava/lang/Long;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;

    .line 5
    invoke-virtual {v0, p3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;->setCrashed(Z)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;

    .line 7
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    move-result-object p1

    return-object p1
.end method

.method a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;
    .locals 1

    .line 1
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->toBuilder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;->setLog(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    move-result-object p1

    return-object p1
.end method

.method a(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;
    .locals 1

    .line 2
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->toBuilder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;

    move-result-object v0

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;->setEvents(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    move-result-object p1

    return-object p1
.end method

.method public abstract getEndedAt()Ljava/lang/Long;
.end method

.method public abstract getEvents()Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;",
            ">;"
        }
    .end annotation
.end method

.method public abstract getIdentifier()Ljava/lang/String;
    .annotation runtime Lcom/google/firebase/encoders/annotations/Encodable$Ignore;
    .end annotation
.end method

.method public getIdentifierUtf8Bytes()[B
    .locals 2
    .annotation runtime Lcom/google/firebase/encoders/annotations/Encodable$Field;
        name = "identifier"
    .end annotation

    .line 1
    invoke-virtual {p0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->getIdentifier()Ljava/lang/String;

    move-result-object v0

    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->a()Ljava/nio/charset/Charset;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/String;->getBytes(Ljava/nio/charset/Charset;)[B

    move-result-object v0

    return-object v0
.end method

.method public abstract getLog()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;
.end method

.method public abstract getStartedAt()J
.end method

.method public abstract isCrashed()Z
.end method

.method public abstract toBuilder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;
.end method
