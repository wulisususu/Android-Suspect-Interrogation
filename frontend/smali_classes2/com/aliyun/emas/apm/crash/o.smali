.class public Lcom/aliyun/emas/apm/crash/o;
.super Ljava/lang/Object;
.source "SourceFile"


# static fields
.field private static final f:Ljava/util/Map;

.field private static final g:Ljava/util/regex/Pattern;


# instance fields
.field private final a:Landroid/content/Context;

.field private final b:Lcom/aliyun/emas/apm/crash/b0;

.field private final c:Lcom/aliyun/emas/apm/crash/a;

.field private final d:Lcom/aliyun/emas/apm/crash/y0;

.field private final e:Lcom/aliyun/emas/apm/crash/x0;


# direct methods
.method static constructor <clinit>()V
    .locals 3

    .line 1
    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    sput-object v0, Lcom/aliyun/emas/apm/crash/o;->f:Ljava/util/Map;

    const/4 v1, 0x5

    .line 4
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "armeabi"

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v1, 0x6

    .line 5
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "armeabi-v7a"

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/16 v1, 0x9

    .line 6
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string v2, "arm64-v8a"

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v1, 0x0

    .line 7
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string/jumbo v2, "x86"

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const/4 v1, 0x1

    .line 8
    invoke-static {v1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v1

    const-string/jumbo v2, "x86_64"

    invoke-interface {v0, v2, v1}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    const-string v0, "[^\\p{Alnum}]"

    .line 506
    invoke-static {v0}, Ljava/util/regex/Pattern;->compile(Ljava/lang/String;)Ljava/util/regex/Pattern;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/o;->g:Ljava/util/regex/Pattern;

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;Lcom/aliyun/emas/apm/crash/b0;Lcom/aliyun/emas/apm/crash/a;Lcom/aliyun/emas/apm/crash/y0;Lcom/aliyun/emas/apm/crash/x0;)V
    .locals 0

    .line 1
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/aliyun/emas/apm/crash/o;->a:Landroid/content/Context;

    iput-object p2, p0, Lcom/aliyun/emas/apm/crash/o;->b:Lcom/aliyun/emas/apm/crash/b0;

    iput-object p3, p0, Lcom/aliyun/emas/apm/crash/o;->c:Lcom/aliyun/emas/apm/crash/a;

    iput-object p4, p0, Lcom/aliyun/emas/apm/crash/o;->d:Lcom/aliyun/emas/apm/crash/y0;

    iput-object p5, p0, Lcom/aliyun/emas/apm/crash/o;->e:Lcom/aliyun/emas/apm/crash/x0;

    return-void
.end method

.method private static a(J)J
    .locals 3

    const-wide/16 v0, 0x0

    cmp-long v2, p0, v0

    if-lez v2, :cond_0

    goto :goto_0

    :cond_0
    move-wide p0, v0

    :goto_0
    return-wide p0
.end method

.method private a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;
    .locals 4

    const/4 v0, 0x0

    if-nez p1, :cond_0

    goto :goto_0

    .line 40
    :cond_0
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    move-result-object v1

    .line 41
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;->getImportance()I

    move-result v2

    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setImportance(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    move-result-object v1

    .line 42
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;->getProcessName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setProcessName(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    move-result-object v1

    .line 43
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;->getReasonCode()I

    move-result v2

    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setReasonCode(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    move-result-object v1

    .line 44
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;->getTimestamp()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setTimestamp(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    move-result-object v1

    .line 45
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;->getPid()I

    move-result v2

    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setPid(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    move-result-object v1

    .line 46
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;->getPss()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setPss(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    move-result-object v1

    .line 47
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;->getRss()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setRss(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    move-result-object v1

    .line 48
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;->getTraceFile()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setTraceFile(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    move-result-object p1

    .line 49
    invoke-virtual {p1, v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->setBuildIdMappingForArch(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;

    move-result-object p1

    .line 50
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;

    move-result-object v0

    :goto_0
    return-object v0
.end method

.method private a()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;
    .locals 3

    .line 51
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object v0

    const-string v1, "1.0"

    .line 52
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setProtocolVersion(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object v0

    const-string v1, "crash"

    .line 53
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setEventId(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/o;->b:Lcom/aliyun/emas/apm/crash/b0;

    .line 54
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/crash/b0;->f()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setUtdid(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/o;->b:Lcom/aliyun/emas/apm/crash/b0;

    .line 55
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/crash/b0;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setSessionId(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object v0

    .line 56
    invoke-static {}, Ljava/util/UUID;->randomUUID()Ljava/util/UUID;

    move-result-object v1

    invoke-virtual {v1}, Ljava/util/UUID;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-direct {p0, v1}, Lcom/aliyun/emas/apm/crash/o;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setUuid(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object v0

    .line 57
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/o;->f()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setSdk(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object v0

    .line 58
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/o;->c()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setApp(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object v0

    .line 59
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/o;->d()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setDevice(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object v0

    const-wide/high16 v1, 0x3ff0000000000000L    # 1.0

    .line 60
    invoke-virtual {v0, v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setSampleRate(D)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object v0

    const-string v1, "android"

    .line 61
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setPlatform(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object v0

    return-object v0
.end method

.method private a(Lcom/aliyun/emas/apm/crash/a1;II)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;
    .locals 1

    const/4 v0, 0x0

    .line 178
    invoke-direct {p0, p1, p2, p3, v0}, Lcom/aliyun/emas/apm/crash/o;->a(Lcom/aliyun/emas/apm/crash/a1;III)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;

    move-result-object p1

    return-object p1
.end method

.method private a(Lcom/aliyun/emas/apm/crash/a1;III)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;
    .locals 5

    .line 179
    iget-object v0, p1, Lcom/aliyun/emas/apm/crash/a1;->b:Ljava/lang/String;

    .line 180
    iget-object v1, p1, Lcom/aliyun/emas/apm/crash/a1;->a:Ljava/lang/String;

    .line 182
    iget-object v2, p1, Lcom/aliyun/emas/apm/crash/a1;->c:[Ljava/lang/StackTraceElement;

    const/4 v3, 0x0

    if-eqz v2, :cond_0

    goto :goto_0

    :cond_0
    new-array v2, v3, [Ljava/lang/StackTraceElement;

    .line 183
    :goto_0
    iget-object p1, p1, Lcom/aliyun/emas/apm/crash/a1;->d:Lcom/aliyun/emas/apm/crash/a1;

    if-lt p4, p3, :cond_1

    move-object v4, p1

    :goto_1
    if-eqz v4, :cond_1

    .line 189
    iget-object v4, v4, Lcom/aliyun/emas/apm/crash/a1;->d:Lcom/aliyun/emas/apm/crash/a1;

    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    .line 195
    :cond_1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;

    move-result-object v4

    .line 196
    invoke-virtual {v4, v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;->setType(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;

    move-result-object v0

    .line 197
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;->setReason(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;

    move-result-object v0

    .line 198
    invoke-direct {p0, v2, p2}, Lcom/aliyun/emas/apm/crash/o;->a([Ljava/lang/StackTraceElement;I)Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;->setFrames(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;

    move-result-object v0

    .line 199
    invoke-virtual {v0, v3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;->setOverflowCount(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;

    move-result-object v0

    if-eqz p1, :cond_2

    if-nez v3, :cond_2

    add-int/lit8 p4, p4, 0x1

    .line 203
    invoke-direct {p0, p1, p2, p3, p4}, Lcom/aliyun/emas/apm/crash/o;->a(Lcom/aliyun/emas/apm/crash/a1;III)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;

    move-result-object p1

    .line 204
    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;->setCausedBy(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;

    .line 209
    :cond_2
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;

    move-result-object p1

    return-object p1
.end method

.method private a(Ljava/lang/StackTraceElement;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame;
    .locals 7

    .line 210
    invoke-virtual {p1}, Ljava/lang/StackTraceElement;->isNativeMethod()Z

    move-result v0

    const-wide/16 v1, 0x0

    if-eqz v0, :cond_0

    .line 213
    invoke-virtual {p1}, Ljava/lang/StackTraceElement;->getLineNumber()I

    move-result v0

    int-to-long v3, v0

    invoke-static {v3, v4, v1, v2}, Ljava/lang/Math;->max(JJ)J

    move-result-wide v3

    goto :goto_0

    :cond_0
    move-wide v3, v1

    .line 216
    :goto_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Ljava/lang/StackTraceElement;->getClassName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const-string v5, "."

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {p1}, Ljava/lang/StackTraceElement;->getMethodName()Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 217
    invoke-virtual {p1}, Ljava/lang/StackTraceElement;->getFileName()Ljava/lang/String;

    move-result-object v5

    .line 222
    invoke-virtual {p1}, Ljava/lang/StackTraceElement;->isNativeMethod()Z

    move-result v6

    if-nez v6, :cond_1

    invoke-virtual {p1}, Ljava/lang/StackTraceElement;->getLineNumber()I

    move-result v6

    if-lez v6, :cond_1

    .line 223
    invoke-virtual {p1}, Ljava/lang/StackTraceElement;->getLineNumber()I

    move-result p1

    int-to-long v1, p1

    .line 226
    :cond_1
    invoke-virtual {p2, v3, v4}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;->setPc(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;

    move-result-object p1

    invoke-virtual {p1, v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;->setSymbol(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;

    move-result-object p1

    invoke-virtual {p1, v5}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;->setFile(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;

    move-result-object p1

    invoke-virtual {p1, v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;->setOffset(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame;

    move-result-object p1

    return-object p1
.end method

.method private a(Ljava/lang/Thread;[Ljava/lang/StackTraceElement;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread;
    .locals 1

    const/4 v0, 0x0

    .line 164
    invoke-direct {p0, p1, p2, v0}, Lcom/aliyun/emas/apm/crash/o;->a(Ljava/lang/Thread;[Ljava/lang/StackTraceElement;I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread;

    move-result-object p1

    return-object p1
.end method

.method private a(Ljava/lang/Thread;[Ljava/lang/StackTraceElement;I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread;
    .locals 1

    .line 165
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Builder;

    move-result-object v0

    .line 166
    invoke-virtual {p1}, Ljava/lang/Thread;->getName()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Builder;->setName(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Builder;

    move-result-object p1

    .line 167
    invoke-virtual {p1, p3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Builder;->setImportance(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Builder;

    move-result-object p1

    .line 168
    invoke-direct {p0, p2, p3}, Lcom/aliyun/emas/apm/crash/o;->a([Ljava/lang/StackTraceElement;I)Ljava/util/List;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Builder;->setFrames(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Builder;

    move-result-object p1

    .line 169
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread;

    move-result-object p1

    return-object p1
.end method

.method private a(Lcom/aliyun/emas/apm/crash/a1;Ljava/lang/Thread;IIZ)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;
    .locals 1

    .line 124
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;

    move-result-object v0

    .line 126
    invoke-direct {p0, p1, p2, p3, p5}, Lcom/aliyun/emas/apm/crash/o;->a(Lcom/aliyun/emas/apm/crash/a1;Ljava/lang/Thread;IZ)Ljava/util/List;

    move-result-object p2

    .line 127
    invoke-virtual {v0, p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;->setThreads(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;

    move-result-object p2

    .line 131
    invoke-direct {p0, p1, p3, p4}, Lcom/aliyun/emas/apm/crash/o;->a(Lcom/aliyun/emas/apm/crash/a1;II)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;

    move-result-object p1

    .line 132
    invoke-virtual {p2, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;->setException(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Exception;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;

    move-result-object p1

    .line 134
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    move-result-object p1

    return-object p1
.end method

.method private a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;
    .locals 1

    .line 135
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;

    move-result-object v0

    .line 136
    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;->setNdkPayload(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;

    move-result-object p1

    .line 137
    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;->setAppExitInfo(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;

    move-result-object p1

    .line 138
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    move-result-object p1

    return-object p1
.end method

.method private a(ILcom/aliyun/emas/apm/crash/a1;Ljava/lang/Thread;IIZ)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;
    .locals 6

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o;->a:Landroid/content/Context;

    .line 62
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/n0;->b(Landroid/content/Context;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;

    move-result-object v0

    .line 63
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;->getImportance()I

    move-result v1

    if-lez v1, :cond_1

    .line 66
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;->getImportance()I

    move-result v1

    const/16 v2, 0x64

    if-eq v1, v2, :cond_0

    const/4 v1, 0x1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    :goto_0
    invoke-static {v1}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v1

    goto :goto_1

    :cond_1
    const/4 v1, 0x0

    .line 70
    :goto_1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    move-result-object v2

    .line 71
    invoke-virtual {v2, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setBackground(Ljava/lang/Boolean;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    move-result-object v1

    .line 72
    invoke-virtual {v1, v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setCurrentProcessDetails(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/o;->a:Landroid/content/Context;

    .line 73
    invoke-static {v1}, Lcom/aliyun/emas/apm/crash/n0;->a(Landroid/content/Context;)Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setAppProcessDetails(Ljava/util/List;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    move-result-object v0

    .line 74
    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setUiOrientation(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    move-result-object p1

    move-object v0, p0

    move-object v1, p2

    move-object v2, p3

    move v3, p4

    move v4, p5

    move v5, p6

    .line 76
    invoke-direct/range {v0 .. v5}, Lcom/aliyun/emas/apm/crash/o;->a(Lcom/aliyun/emas/apm/crash/a1;Ljava/lang/Thread;IIZ)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    move-result-object p2

    .line 77
    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setExecution(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    move-result-object p1

    .line 84
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

    move-result-object p1

    return-object p1
.end method

.method private a(ILcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;
    .locals 2

    .line 85
    invoke-virtual {p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;->getImportance()I

    move-result v0

    const/16 v1, 0x64

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 87
    :goto_0
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    move-result-object v1

    .line 88
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setBackground(Ljava/lang/Boolean;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    move-result-object v0

    .line 89
    invoke-virtual {v0, p3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setCurrentProcessDetails(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    move-result-object p3

    .line 90
    invoke-virtual {p3, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setUiOrientation(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    move-result-object p1

    .line 91
    invoke-direct {p0, p2}, Lcom/aliyun/emas/apm/crash/o;->b(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setExecution(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    move-result-object p1

    .line 92
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

    move-result-object p1

    return-object p1
.end method

.method private a(ILcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;
    .locals 2

    if-eqz p3, :cond_0

    .line 93
    invoke-virtual {p3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;->getImportance()I

    move-result v0

    const/16 v1, 0x64

    if-eq v0, v1, :cond_0

    const/4 v0, 0x1

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    .line 95
    :goto_0
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    move-result-object v1

    .line 96
    invoke-static {v0}, Ljava/lang/Boolean;->valueOf(Z)Ljava/lang/Boolean;

    move-result-object v0

    invoke-virtual {v1, v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setBackground(Ljava/lang/Boolean;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    move-result-object v0

    .line 97
    invoke-virtual {v0, p4}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setCurrentProcessDetails(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    move-result-object p4

    .line 98
    invoke-virtual {p4, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setUiOrientation(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    move-result-object p1

    .line 99
    invoke-direct {p0, p2, p3}, Lcom/aliyun/emas/apm/crash/o;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->setExecution(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;

    move-result-object p1

    .line 100
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

    move-result-object p1

    return-object p1
.end method

.method private a(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;
    .locals 8

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o;->a:Landroid/content/Context;

    .line 101
    invoke-static {v0}, Lcom/aliyun/emas/apm/crash/f;->a(Landroid/content/Context;)Lcom/aliyun/emas/apm/crash/f;

    move-result-object v0

    .line 102
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/f;->a()Ljava/lang/Float;

    move-result-object v1

    if-eqz v1, :cond_0

    .line 103
    invoke-virtual {v1}, Ljava/lang/Float;->doubleValue()D

    move-result-wide v1

    invoke-static {v1, v2}, Ljava/lang/Double;->valueOf(D)Ljava/lang/Double;

    move-result-object v1

    goto :goto_0

    :cond_0
    const/4 v1, 0x0

    .line 104
    :goto_0
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/f;->b()I

    move-result v0

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/o;->a:Landroid/content/Context;

    .line 105
    invoke-static {v2}, Lcom/aliyun/emas/apm/crash/i;->d(Landroid/content/Context;)Z

    move-result v2

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/o;->a:Landroid/content/Context;

    .line 108
    invoke-static {v3}, Lcom/aliyun/emas/apm/crash/i;->b(Landroid/content/Context;)J

    move-result-wide v3

    iget-object v5, p0, Lcom/aliyun/emas/apm/crash/o;->a:Landroid/content/Context;

    .line 109
    invoke-static {v5}, Lcom/aliyun/emas/apm/crash/i;->a(Landroid/content/Context;)J

    move-result-wide v5

    sub-long/2addr v3, v5

    .line 110
    invoke-static {v3, v4}, Lcom/aliyun/emas/apm/crash/o;->a(J)J

    move-result-wide v3

    .line 114
    invoke-static {}, Landroid/os/Environment;->getDataDirectory()Ljava/io/File;

    move-result-object v5

    invoke-virtual {v5}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v5

    invoke-static {v5}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/lang/String;)J

    move-result-wide v5

    .line 116
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;

    move-result-object v7

    .line 117
    invoke-virtual {v7, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;->setBatteryLevel(Ljava/lang/Double;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;

    move-result-object v1

    .line 118
    invoke-virtual {v1, v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;->setBatteryVelocity(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;

    move-result-object v0

    .line 119
    invoke-virtual {v0, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;->setProximityOn(Z)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;

    move-result-object v0

    .line 120
    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;->setOrientation(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;

    move-result-object p1

    .line 121
    invoke-virtual {p1, v3, v4}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;->setRamUsed(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;

    move-result-object p1

    .line 122
    invoke-virtual {p1, v5, v6}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;->setDiskUsed(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;

    move-result-object p1

    .line 123
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;

    move-result-object p1

    return-object p1
.end method

.method private a(Ljava/lang/String;)Ljava/lang/String;
    .locals 1

    sget-object v0, Lcom/aliyun/emas/apm/crash/o;->g:Ljava/util/regex/Pattern;

    .line 227
    invoke-virtual {v0, p1}, Ljava/util/regex/Pattern;->matcher(Ljava/lang/CharSequence;)Ljava/util/regex/Matcher;

    move-result-object p1

    const-string v0, ""

    invoke-virtual {p1, v0}, Ljava/util/regex/Matcher;->replaceAll(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {p1, v0}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object p1

    return-object p1
.end method

.method private a(Lcom/aliyun/emas/apm/crash/a1;Ljava/lang/Thread;IZ)Ljava/util/List;
    .locals 2

    .line 139
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 141
    iget-object p1, p1, Lcom/aliyun/emas/apm/crash/a1;->c:[Ljava/lang/StackTraceElement;

    .line 142
    invoke-direct {p0, p2, p1, p3}, Lcom/aliyun/emas/apm/crash/o;->a(Ljava/lang/Thread;[Ljava/lang/StackTraceElement;I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread;

    move-result-object p1

    .line 143
    invoke-interface {v0, p1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    if-eqz p4, :cond_1

    .line 147
    invoke-static {}, Ljava/lang/Thread;->getAllStackTraces()Ljava/util/Map;

    move-result-object p1

    .line 148
    invoke-interface {p1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object p1

    invoke-interface {p1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :cond_0
    :goto_0
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result p3

    if-eqz p3, :cond_1

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, Ljava/util/Map$Entry;

    .line 149
    invoke-interface {p3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object p4

    check-cast p4, Ljava/lang/Thread;

    .line 151
    invoke-virtual {p4, p2}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result v1

    if-nez v1, :cond_0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/o;->d:Lcom/aliyun/emas/apm/crash/y0;

    .line 154
    invoke-interface {p3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object p3

    check-cast p3, [Ljava/lang/StackTraceElement;

    invoke-interface {v1, p3}, Lcom/aliyun/emas/apm/crash/y0;->a([Ljava/lang/StackTraceElement;)[Ljava/lang/StackTraceElement;

    move-result-object p3

    .line 155
    invoke-direct {p0, p4, p3}, Lcom/aliyun/emas/apm/crash/o;->a(Ljava/lang/Thread;[Ljava/lang/StackTraceElement;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread;

    move-result-object p3

    .line 156
    invoke-interface {v0, p3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    .line 163
    :cond_1
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object p1

    return-object p1
.end method

.method private a([Ljava/lang/StackTraceElement;I)Ljava/util/List;
    .locals 5

    .line 170
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    .line 171
    array-length v1, p1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_0

    aget-object v3, p1, v2

    .line 173
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;

    move-result-object v4

    invoke-virtual {v4, p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;->setImportance(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;

    move-result-object v4

    invoke-direct {p0, v3, v4}, Lcom/aliyun/emas/apm/crash/o;->a(Ljava/lang/StackTraceElement;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame$Builder;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Thread$Frame;

    move-result-object v3

    .line 174
    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    .line 177
    :cond_0
    invoke-interface {v0}, Ljava/util/List;->isEmpty()Z

    move-result p1

    if-eqz p1, :cond_1

    const/4 p1, 0x0

    goto :goto_1

    :cond_1
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object p1

    :goto_1
    return-object p1
.end method

.method private a([B)[B
    .locals 2

    .line 228
    new-instance v0, Ljava/io/ByteArrayOutputStream;

    invoke-direct {v0}, Ljava/io/ByteArrayOutputStream;-><init>()V

    .line 229
    :try_start_0
    new-instance v1, Ljava/util/zip/GZIPOutputStream;

    invoke-direct {v1, v0}, Ljava/util/zip/GZIPOutputStream;-><init>(Ljava/io/OutputStream;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_2

    .line 230
    :try_start_1
    invoke-virtual {v1, p1}, Ljava/io/OutputStream;->write([B)V

    .line 231
    invoke-virtual {v1}, Ljava/util/zip/GZIPOutputStream;->finish()V

    .line 233
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->toByteArray()[B

    move-result-object p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 234
    :try_start_2
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_2

    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->close()V

    return-object p1

    :catchall_0
    move-exception p1

    .line 235
    :try_start_3
    invoke-virtual {v1}, Ljava/io/OutputStream;->close()V
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    goto :goto_0

    :catchall_1
    move-exception v1

    :try_start_4
    invoke-virtual {p1, v1}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_0
    throw p1
    :try_end_4
    .catchall {:try_start_4 .. :try_end_4} :catchall_2

    :catchall_2
    move-exception p1

    :try_start_5
    invoke-virtual {v0}, Ljava/io/ByteArrayOutputStream;->close()V
    :try_end_5
    .catchall {:try_start_5 .. :try_end_5} :catchall_3

    goto :goto_1

    :catchall_3
    move-exception v0

    invoke-virtual {p1, v0}, Ljava/lang/Throwable;->addSuppressed(Ljava/lang/Throwable;)V

    :goto_1
    throw p1
.end method

.method private static b()I
    .locals 4

    .line 33
    sget-object v0, Landroid/os/Build;->CPU_ABI:Ljava/lang/String;

    .line 35
    invoke-static {v0}, Landroid/text/TextUtils;->isEmpty(Ljava/lang/CharSequence;)Z

    move-result v1

    const/4 v2, 0x7

    if-eqz v1, :cond_0

    return v2

    :cond_0
    sget-object v1, Lcom/aliyun/emas/apm/crash/o;->f:Ljava/util/Map;

    .line 39
    sget-object v3, Ljava/util/Locale;->US:Ljava/util/Locale;

    invoke-virtual {v0, v3}, Ljava/lang/String;->toLowerCase(Ljava/util/Locale;)Ljava/lang/String;

    move-result-object v0

    invoke-interface {v1, v0}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/lang/Integer;

    if-nez v0, :cond_1

    return v2

    .line 44
    :cond_1
    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    return v0
.end method

.method private b(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;
    .locals 1

    .line 30
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;

    move-result-object v0

    .line 31
    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;->setAppExitInfo(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;

    move-result-object p1

    .line 32
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$Execution;

    move-result-object p1

    return-object p1
.end method

.method private b(Ljava/lang/String;J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;
    .locals 1

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;

    move-result-object v0

    .line 2
    invoke-virtual {v0, p2, p3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;->setStartedAt(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;

    move-result-object p2

    .line 3
    invoke-virtual {p2, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;->setIdentifier(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;

    move-result-object p1

    .line 4
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    move-result-object p1

    return-object p1
.end method

.method private b(Ljava/lang/String;)[B
    .locals 8

    const-string v0, "java"

    .line 5
    invoke-virtual {v0, p1}, Ljava/lang/String;->equals(Ljava/lang/Object;)Z

    move-result p1

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return-object v0

    .line 9
    :cond_0
    new-instance p1, Ljava/lang/ProcessBuilder;

    const/4 v1, 0x0

    new-array v1, v1, [Ljava/lang/String;

    invoke-direct {p1, v1}, Ljava/lang/ProcessBuilder;-><init>([Ljava/lang/String;)V

    const-string v2, "logcat"

    const-string v3, "-d"

    const-string v4, "-v"

    const-string v5, "threadtime"

    const-string v6, "-t"

    const-string v7, "1000"

    .line 10
    filled-new-array/range {v2 .. v7}, [Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p1, v1}, Ljava/lang/ProcessBuilder;->command([Ljava/lang/String;)Ljava/lang/ProcessBuilder;

    .line 15
    :try_start_0
    invoke-virtual {p1}, Ljava/lang/ProcessBuilder;->start()Ljava/lang/Process;

    move-result-object p1

    .line 16
    new-instance v1, Ljava/io/BufferedReader;

    new-instance v2, Ljava/io/InputStreamReader;

    invoke-virtual {p1}, Ljava/lang/Process;->getInputStream()Ljava/io/InputStream;

    move-result-object p1

    invoke-direct {v2, p1}, Ljava/io/InputStreamReader;-><init>(Ljava/io/InputStream;)V

    invoke-direct {v1, v2}, Ljava/io/BufferedReader;-><init>(Ljava/io/Reader;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 17
    :try_start_1
    new-instance p1, Ljava/lang/StringBuilder;

    invoke-direct {p1}, Ljava/lang/StringBuilder;-><init>()V

    .line 20
    :goto_0
    invoke-virtual {v1}, Ljava/io/BufferedReader;->readLine()Ljava/lang/String;

    move-result-object v2

    if-eqz v2, :cond_1

    .line 21
    invoke-virtual {p1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v3, "\n"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 24
    :cond_1
    invoke-virtual {p1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {p1}, Ljava/lang/String;->getBytes()[B

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/o;->a([B)[B

    move-result-object p1
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_1

    .line 28
    invoke-static {v1}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;)V

    return-object p1

    :catchall_0
    move-object v1, v0

    .line 29
    :catchall_1
    invoke-static {v1}, Lcom/aliyun/emas/apm/crash/i;->a(Ljava/io/Closeable;)V

    return-object v0
.end method

.method private c()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;
    .locals 3

    const/4 v0, 0x0

    :try_start_0
    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/o;->a:Landroid/content/Context;

    .line 1
    invoke-virtual {v1}, Landroid/content/Context;->getApplicationInfo()Landroid/content/pm/ApplicationInfo;

    move-result-object v1

    .line 2
    iget v1, v1, Landroid/content/pm/ApplicationInfo;->flags:I
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    and-int/lit8 v1, v1, 0x2

    if-eqz v1, :cond_0

    const/4 v0, 0x1

    .line 7
    :catch_0
    :cond_0
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;

    move-result-object v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/o;->b:Lcom/aliyun/emas/apm/crash/b0;

    .line 8
    invoke-virtual {v2}, Lcom/aliyun/emas/apm/crash/b0;->b()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;->setName(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;

    move-result-object v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/o;->c:Lcom/aliyun/emas/apm/crash/a;

    iget-object v2, v2, Lcom/aliyun/emas/apm/crash/a;->c:Ljava/lang/String;

    .line 9
    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;->setBuild(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;

    move-result-object v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/o;->c:Lcom/aliyun/emas/apm/crash/a;

    iget-object v2, v2, Lcom/aliyun/emas/apm/crash/a;->d:Ljava/lang/String;

    .line 10
    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;->setVersion(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;

    move-result-object v1

    iget-object v2, p0, Lcom/aliyun/emas/apm/crash/o;->c:Lcom/aliyun/emas/apm/crash/a;

    iget-object v2, v2, Lcom/aliyun/emas/apm/crash/a;->e:Ljava/lang/String;

    .line 11
    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;->setChannel(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;

    move-result-object v1

    .line 12
    invoke-virtual {v1, v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;->setDebuggable(Z)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/o;->c:Lcom/aliyun/emas/apm/crash/a;

    iget-object v1, v1, Lcom/aliyun/emas/apm/crash/a;->f:Lcom/aliyun/emas/apm/crash/x;

    .line 13
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/crash/x;->a()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;->setDevelopmentPlatform(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;

    move-result-object v0

    iget-object v1, p0, Lcom/aliyun/emas/apm/crash/o;->c:Lcom/aliyun/emas/apm/crash/a;

    iget-object v1, v1, Lcom/aliyun/emas/apm/crash/a;->f:Lcom/aliyun/emas/apm/crash/x;

    .line 15
    invoke-virtual {v1}, Lcom/aliyun/emas/apm/crash/x;->b()Ljava/lang/String;

    move-result-object v1

    .line 16
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;->setDevelopmentPlatformVersion(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;

    move-result-object v0

    .line 18
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$App;

    move-result-object v0

    return-object v0
.end method

.method private d()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;
    .locals 12

    .line 1
    new-instance v0, Landroid/os/StatFs;

    invoke-static {}, Landroid/os/Environment;->getDataDirectory()Ljava/io/File;

    move-result-object v1

    invoke-virtual {v1}, Ljava/io/File;->getPath()Ljava/lang/String;

    move-result-object v1

    invoke-direct {v0, v1}, Landroid/os/StatFs;-><init>(Ljava/lang/String;)V

    .line 2
    invoke-static {}, Lcom/aliyun/emas/apm/crash/o;->b()I

    move-result v1

    .line 3
    invoke-static {}, Ljava/lang/Runtime;->getRuntime()Ljava/lang/Runtime;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/Runtime;->availableProcessors()I

    move-result v2

    iget-object v3, p0, Lcom/aliyun/emas/apm/crash/o;->a:Landroid/content/Context;

    .line 4
    invoke-static {v3}, Lcom/aliyun/emas/apm/crash/i;->b(Landroid/content/Context;)J

    move-result-wide v3

    .line 5
    invoke-virtual {v0}, Landroid/os/StatFs;->getBlockCount()I

    move-result v5

    int-to-long v5, v5

    invoke-virtual {v0}, Landroid/os/StatFs;->getBlockSize()I

    move-result v0

    int-to-long v7, v0

    mul-long/2addr v5, v7

    .line 6
    invoke-static {}, Lcom/aliyun/emas/apm/crash/i;->d()Z

    move-result v0

    .line 7
    invoke-static {}, Lcom/aliyun/emas/apm/crash/i;->a()I

    move-result v7

    .line 8
    sget-object v8, Landroid/os/Build;->MANUFACTURER:Ljava/lang/String;

    .line 9
    sget-object v9, Landroid/os/Build;->PRODUCT:Ljava/lang/String;

    .line 11
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    move-result-object v10

    sget-object v11, Landroid/os/Build$VERSION;->RELEASE:Ljava/lang/String;

    .line 12
    invoke-virtual {v10, v11}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setVersion(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    move-result-object v10

    sget-object v11, Landroid/os/Build;->BRAND:Ljava/lang/String;

    .line 13
    invoke-virtual {v10, v11}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setBrand(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    move-result-object v10

    sget-object v11, Landroid/os/Build;->MODEL:Ljava/lang/String;

    .line 14
    invoke-virtual {v10, v11}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setModel(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    move-result-object v10

    const-string v11, "Android"

    .line 15
    invoke-virtual {v10, v11}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setOs(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    move-result-object v10

    .line 16
    invoke-static {}, Lcom/aliyun/emas/apm/crash/i;->b()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setLanguage(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    move-result-object v10

    iget-object v11, p0, Lcom/aliyun/emas/apm/crash/o;->a:Landroid/content/Context;

    .line 17
    invoke-static {v11}, Lcom/aliyun/emas/apm/crash/i;->e(Landroid/content/Context;)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v10, v11}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setResolution(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    move-result-object v10

    .line 18
    invoke-virtual {v10, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setArch(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    move-result-object v1

    .line 19
    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setCores(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    move-result-object v1

    .line 20
    invoke-virtual {v1, v3, v4}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setRam(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    move-result-object v1

    .line 21
    invoke-virtual {v1, v5, v6}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setDiskSpace(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    move-result-object v1

    .line 22
    invoke-virtual {v1, v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setSimulator(Z)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    move-result-object v0

    .line 23
    invoke-virtual {v0, v7}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setState(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    move-result-object v0

    .line 24
    invoke-virtual {v0, v8}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setManufacturer(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    move-result-object v0

    .line 25
    invoke-virtual {v0, v9}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setModelClass(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    move-result-object v0

    .line 26
    invoke-static {}, Lcom/aliyun/emas/apm/crash/i;->e()Z

    move-result v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->setJailbroken(Z)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;

    move-result-object v0

    .line 27
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Device;

    move-result-object v0

    return-object v0
.end method

.method private e()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;
    .locals 6

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o;->a:Landroid/content/Context;

    const-string v1, "activity"

    .line 1
    invoke-virtual {v0, v1}, Landroid/content/Context;->getSystemService(Ljava/lang/String;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Landroid/app/ActivityManager;

    .line 2
    invoke-static {}, Landroid/os/Process;->myPid()I

    move-result v1

    filled-new-array {v1}, [I

    move-result-object v1

    invoke-virtual {v0, v1}, Landroid/app/ActivityManager;->getProcessMemoryInfo([I)[Landroid/os/Debug$MemoryInfo;

    move-result-object v0

    if-eqz v0, :cond_1

    .line 4
    array-length v1, v0

    if-lez v1, :cond_1

    const/4 v1, 0x0

    .line 5
    aget-object v0, v0, v1

    .line 7
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    .line 9
    invoke-virtual {v0}, Landroid/os/Debug$MemoryInfo;->getMemoryStats()Ljava/util/Map;

    move-result-object v2

    .line 10
    invoke-interface {v2}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v2

    invoke-interface {v2}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/util/Map$Entry;

    .line 11
    invoke-interface {v3}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-virtual {v1, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "\t"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-interface {v3}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/lang/String;

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v3

    const-string v4, "\n"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    goto :goto_0

    .line 15
    :cond_0
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    move-result-object v2

    iget v3, v0, Landroid/os/Debug$MemoryInfo;->dalvikPrivateDirty:I

    .line 16
    invoke-virtual {v2, v3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setDalvikPrivateDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    move-result-object v2

    iget v3, v0, Landroid/os/Debug$MemoryInfo;->dalvikPss:I

    .line 17
    invoke-virtual {v2, v3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setDalvikPss(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    move-result-object v2

    iget v3, v0, Landroid/os/Debug$MemoryInfo;->dalvikSharedDirty:I

    .line 18
    invoke-virtual {v2, v3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setDalvikSharedDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    move-result-object v2

    iget v3, v0, Landroid/os/Debug$MemoryInfo;->nativePrivateDirty:I

    .line 19
    invoke-virtual {v2, v3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setNativePrivateDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    move-result-object v2

    iget v3, v0, Landroid/os/Debug$MemoryInfo;->nativePss:I

    .line 20
    invoke-virtual {v2, v3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setNativePss(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    move-result-object v2

    iget v3, v0, Landroid/os/Debug$MemoryInfo;->nativeSharedDirty:I

    .line 21
    invoke-virtual {v2, v3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setNativeSharedDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    move-result-object v2

    iget v3, v0, Landroid/os/Debug$MemoryInfo;->otherPrivateDirty:I

    .line 22
    invoke-virtual {v2, v3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setOtherPrivateDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    move-result-object v2

    iget v3, v0, Landroid/os/Debug$MemoryInfo;->otherPss:I

    .line 23
    invoke-virtual {v2, v3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setOtherPss(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    move-result-object v2

    iget v3, v0, Landroid/os/Debug$MemoryInfo;->otherSharedDirty:I

    .line 24
    invoke-virtual {v2, v3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setOtherSharedDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    move-result-object v2

    .line 25
    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v2, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setMemoryStat(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    move-result-object v1

    .line 26
    invoke-virtual {v0}, Landroid/os/Debug$MemoryInfo;->getTotalSwappablePss()I

    move-result v2

    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setTotalSwappablePss(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    move-result-object v1

    .line 27
    invoke-virtual {v0}, Landroid/os/Debug$MemoryInfo;->getTotalSharedDirty()I

    move-result v2

    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setTotalSharedDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    move-result-object v1

    .line 28
    invoke-virtual {v0}, Landroid/os/Debug$MemoryInfo;->getTotalSharedClean()I

    move-result v2

    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setTotalSharedClean(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    move-result-object v1

    .line 29
    invoke-virtual {v0}, Landroid/os/Debug$MemoryInfo;->getTotalPss()I

    move-result v2

    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setTotalPss(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    move-result-object v1

    .line 30
    invoke-virtual {v0}, Landroid/os/Debug$MemoryInfo;->getTotalPrivateDirty()I

    move-result v2

    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setTotalPrivateDirty(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    move-result-object v1

    .line 31
    invoke-virtual {v0}, Landroid/os/Debug$MemoryInfo;->getTotalPrivateClean()I

    move-result v0

    invoke-virtual {v1, v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->setTotalPrivateClean(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;

    move-result-object v0

    .line 32
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;

    move-result-object v0

    return-object v0

    :cond_1
    const/4 v0, 0x0

    return-object v0
.end method

.method private f()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;
    .locals 2

    .line 1
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk$Builder;

    move-result-object v0

    const-string v1, "crashAnalysis"

    .line 2
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk$Builder;->setName(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk$Builder;

    move-result-object v0

    const-string v1, "3.2.0"

    .line 3
    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk$Builder;->setVersion(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk$Builder;

    move-result-object v0

    .line 4
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Sdk;

    move-result-object v0

    return-object v0
.end method


# virtual methods
.method public a(JLcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;
    .locals 3

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o;->a:Landroid/content/Context;

    .line 32
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    .line 34
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object v1

    const-string v2, "native"

    .line 35
    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setType(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object v1

    if-eqz p4, :cond_0

    .line 36
    invoke-virtual {p4}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;->getTimestamp()J

    move-result-wide p1

    :cond_0
    invoke-virtual {v1, p1, p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setTimestamp(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object p1

    .line 37
    invoke-direct {p0, p4}, Lcom/aliyun/emas/apm/crash/o;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;

    move-result-object p2

    invoke-direct {p0, v0, p3, p2, p5}, Lcom/aliyun/emas/apm/crash/o;->a(ILcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$FilesPayload;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setApp(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object p1

    .line 38
    invoke-direct {p0, v0}, Lcom/aliyun/emas/apm/crash/o;->a(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setDevice(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object p1

    .line 39
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object p1

    return-object p1
.end method

.method public a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;
    .locals 4

    iget-object v0, p0, Lcom/aliyun/emas/apm/crash/o;->a:Landroid/content/Context;

    .line 24
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v0, v0, Landroid/content/res/Configuration;->orientation:I

    .line 26
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object v1

    const-string v2, "anr"

    .line 27
    invoke-virtual {v1, v2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setType(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object v1

    .line 28
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;->getTimestamp()J

    move-result-wide v2

    invoke-virtual {v1, v2, v3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setTimestamp(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object v1

    .line 29
    invoke-direct {p0, p1}, Lcom/aliyun/emas/apm/crash/o;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;

    move-result-object p1

    invoke-direct {p0, v0, p1, p2}, Lcom/aliyun/emas/apm/crash/o;->a(ILcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$ApplicationExitInfo;Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application$ProcessDetails;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

    move-result-object p1

    invoke-virtual {v1, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setApp(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object p1

    .line 30
    invoke-direct {p0, v0}, Lcom/aliyun/emas/apm/crash/o;->a(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;

    move-result-object p2

    invoke-virtual {p1, p2}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setDevice(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object p1

    .line 31
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object p1

    return-object p1
.end method

.method public a(Ljava/lang/Throwable;Ljava/lang/Thread;Ljava/lang/String;JIIZ)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;
    .locals 11

    move-object v7, p0

    move-object v8, p3

    iget-object v0, v7, Lcom/aliyun/emas/apm/crash/o;->a:Landroid/content/Context;

    .line 3
    invoke-virtual {v0}, Landroid/content/Context;->getResources()Landroid/content/res/Resources;

    move-result-object v0

    invoke-virtual {v0}, Landroid/content/res/Resources;->getConfiguration()Landroid/content/res/Configuration;

    move-result-object v0

    iget v9, v0, Landroid/content/res/Configuration;->orientation:I

    iget-object v0, v7, Lcom/aliyun/emas/apm/crash/o;->d:Lcom/aliyun/emas/apm/crash/y0;

    move-object v1, p1

    .line 5
    invoke-static {p1, v0}, Lcom/aliyun/emas/apm/crash/a1;->a(Ljava/lang/Throwable;Lcom/aliyun/emas/apm/crash/y0;)Lcom/aliyun/emas/apm/crash/a1;

    move-result-object v2

    .line 7
    invoke-static {}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->builder()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object v0

    .line 8
    invoke-virtual {v0, p3}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setType(Ljava/lang/String;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object v0

    move-wide v3, p4

    .line 9
    invoke-virtual {v0, v3, v4}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setTimestamp(J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object v10

    move-object v0, p0

    move v1, v9

    move-object v3, p2

    move/from16 v4, p6

    move/from16 v5, p7

    move/from16 v6, p8

    .line 11
    invoke-direct/range {v0 .. v6}, Lcom/aliyun/emas/apm/crash/o;->a(ILcom/aliyun/emas/apm/crash/a1;Ljava/lang/Thread;IIZ)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

    move-result-object v0

    .line 12
    invoke-virtual {v10, v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setApp(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object v0

    .line 20
    invoke-direct {p0, v9}, Lcom/aliyun/emas/apm/crash/o;->a(I)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setDevice(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object v0

    .line 21
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/o;->e()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setMemory(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object v0

    .line 22
    invoke-direct {p0, p3}, Lcom/aliyun/emas/apm/crash/o;->b(Ljava/lang/String;)[B

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->setLogcat([B)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;

    move-result-object v0

    .line 23
    invoke-virtual {v0}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    move-result-object v0

    return-object v0
.end method

.method public a(Ljava/lang/String;J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;
    .locals 1

    .line 2
    invoke-direct {p0}, Lcom/aliyun/emas/apm/crash/o;->a()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object v0

    invoke-direct {p0, p1, p2, p3}, Lcom/aliyun/emas/apm/crash/o;->b(Ljava/lang/String;J)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;

    move-result-object p1

    invoke-virtual {v0, p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->setPayload(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session;)Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;

    move-result-object p1

    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Builder;->build()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport;

    move-result-object p1

    return-object p1
.end method
