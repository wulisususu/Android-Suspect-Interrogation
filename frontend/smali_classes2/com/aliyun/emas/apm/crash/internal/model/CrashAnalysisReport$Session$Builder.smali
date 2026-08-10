.class public abstract Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;
.super Ljava/lang/Object;
.source "SourceFile"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x409
    name = "Builder"
.end annotation


# direct methods
.method public constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public abstract build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;
.end method

.method public abstract setCrashed(Z)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;
.end method

.method public abstract setEndedAt(Ljava/lang/Long;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;
.end method

.method public abstract setEvents(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/util/List<",
            "Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;",
            ">;)",
            "Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;"
        }
    .end annotation
.end method

.method public abstract setIdentifier(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;
.end method

.method public setIdentifierFromUtf8Bytes([B)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;
    .locals 2

    .line 1
    new-instance v0, Ljava/lang/String;

    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->a()Ljava/nio/charset/Charset;

    move-result-object v1

    invoke-direct {v0, p1, v1}, Ljava/lang/String;-><init>([BLjava/nio/charset/Charset;)V

    invoke-virtual {p0, v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;->setIdentifier(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;

    move-result-object p1

    return-object p1
.end method

.method public abstract setLog(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Log;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;
.end method

.method public abstract setStartedAt(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;
.end method
