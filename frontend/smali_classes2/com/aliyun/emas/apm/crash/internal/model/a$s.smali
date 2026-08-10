.class final Lcom/aliyun/emas/apm/crash/internal/model/a$s;
.super Ljava/lang/Object;
.source "SourceFile"

# interfaces
.implements Lcom/google/firebase/encoders/ObjectEncoder;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/aliyun/emas/apm/crash/internal/model/a;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x1a
    name = "s"
.end annotation


# static fields
.field static final a:Lcom/aliyun/emas/apm/crash/internal/model/a$s;

.field private static final b:Lcom/google/firebase/encoders/FieldDescriptor;

.field private static final c:Lcom/google/firebase/encoders/FieldDescriptor;

.field private static final d:Lcom/google/firebase/encoders/FieldDescriptor;

.field private static final e:Lcom/google/firebase/encoders/FieldDescriptor;

.field private static final f:Lcom/google/firebase/encoders/FieldDescriptor;

.field private static final g:Lcom/google/firebase/encoders/FieldDescriptor;

.field private static final h:Lcom/google/firebase/encoders/FieldDescriptor;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 1
    new-instance v0, Lcom/aliyun/emas/apm/crash/internal/model/a$s;

    invoke-direct {v0}, Lcom/aliyun/emas/apm/crash/internal/model/a$s;-><init>()V

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$s;->a:Lcom/aliyun/emas/apm/crash/internal/model/a$s;

    const-string v0, "timestamp"

    .line 3
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$s;->b:Lcom/google/firebase/encoders/FieldDescriptor;

    const-string v0, "type"

    .line 5
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$s;->c:Lcom/google/firebase/encoders/FieldDescriptor;

    const-string v0, "app"

    .line 7
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$s;->d:Lcom/google/firebase/encoders/FieldDescriptor;

    const-string v0, "device"

    .line 9
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$s;->e:Lcom/google/firebase/encoders/FieldDescriptor;

    const-string v0, "memory"

    .line 11
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$s;->f:Lcom/google/firebase/encoders/FieldDescriptor;

    const-string v0, "logcat"

    .line 13
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$s;->g:Lcom/google/firebase/encoders/FieldDescriptor;

    const-string v0, "rollouts"

    .line 15
    invoke-static {v0}, Lcom/google/firebase/encoders/FieldDescriptor;->of(Ljava/lang/String;)Lcom/google/firebase/encoders/FieldDescriptor;

    move-result-object v0

    sput-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$s;->h:Lcom/google/firebase/encoders/FieldDescriptor;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;Lcom/google/firebase/encoders/ObjectEncoderContext;)V
    .locals 3

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$s;->b:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 1
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->getTimestamp()J

    move-result-wide v1

    invoke-interface {p2, v0, v1, v2}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;J)Lcom/google/firebase/encoders/ObjectEncoderContext;

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$s;->c:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 2
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->getType()Ljava/lang/String;

    move-result-object v1

    invoke-interface {p2, v0, v1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;Ljava/lang/Object;)Lcom/google/firebase/encoders/ObjectEncoderContext;

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$s;->d:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 3
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->getApp()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Application;

    move-result-object v1

    invoke-interface {p2, v0, v1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;Ljava/lang/Object;)Lcom/google/firebase/encoders/ObjectEncoderContext;

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$s;->e:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 4
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->getDevice()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Device;

    move-result-object v1

    invoke-interface {p2, v0, v1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;Ljava/lang/Object;)Lcom/google/firebase/encoders/ObjectEncoderContext;

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$s;->f:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 5
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->getMemory()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$Memory;

    move-result-object v1

    invoke-interface {p2, v0, v1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;Ljava/lang/Object;)Lcom/google/firebase/encoders/ObjectEncoderContext;

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$s;->g:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 6
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->getLogcat()[B

    move-result-object v1

    invoke-interface {p2, v0, v1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;Ljava/lang/Object;)Lcom/google/firebase/encoders/ObjectEncoderContext;

    sget-object v0, Lcom/aliyun/emas/apm/crash/internal/model/a$s;->h:Lcom/google/firebase/encoders/FieldDescriptor;

    .line 7
    invoke-virtual {p1}, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;->getRollouts()Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event$RolloutsState;

    move-result-object p1

    invoke-interface {p2, v0, p1}, Lcom/google/firebase/encoders/ObjectEncoderContext;->add(Lcom/google/firebase/encoders/FieldDescriptor;Ljava/lang/Object;)Lcom/google/firebase/encoders/ObjectEncoderContext;

    return-void
.end method

.method public bridge synthetic encode(Ljava/lang/Object;Ljava/lang/Object;)V
    .locals 0

    .line 1
    check-cast p1, Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;

    check-cast p2, Lcom/google/firebase/encoders/ObjectEncoderContext;

    invoke-virtual {p0, p1, p2}, Lcom/aliyun/emas/apm/crash/internal/model/a$s;->a(Lcom/aliyun/emas/apm/crash/internal/model/CrashAnalysisReport$Session$Event;Lcom/google/firebase/encoders/ObjectEncoderContext;)V

    return-void
.end method
